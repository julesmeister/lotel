import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

double? getTotalAmount(
  String beds,
  int nights,
  double roomPrice,
  double bedPrice,
  String startingBeds,
  int startingNights,
  double? lateCheckoutFee,
  List<TransactionsRecord>? transactions,
) {
  double totalAmount = 0.0;

  int parsedStartingBeds = int.tryParse(startingBeds) ?? 0;
  int parsedBeds = int.tryParse(beds) ?? 0;

  if (parsedStartingBeds == -1) {
    totalAmount += parsedBeds * bedPrice;
  } else {
    int bedDifference = parsedBeds - parsedStartingBeds;
    totalAmount += bedDifference * bedPrice;
  }

  if (startingNights != 0) {
    int nightDifference = nights - startingNights;
    totalAmount += nightDifference * roomPrice;
  } else {
    totalAmount += nights * roomPrice;
  }

  // Add late checkout fee if indicated
  if (lateCheckoutFee != null) {
    totalAmount += lateCheckoutFee;
  }

  return totalAmount;
}

int? stringToInt(String? text) {
  // convert text to integer
  try {
    return int.parse(text!);
  } catch (e) {
    return null;
  }
}

String? paidOrPending(bool? paid) {
  // pending if false paid if true
  if (paid == true) {
    return 'paid';
  } else {
    return 'pending';
  }
}

DateTime? yesterdayDate() {
  // yesterday starting midnight
  final now = DateTime.now();
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  return yesterday;
}

String? whichItemCategory(String? category) {
  // if category is "All" return nothing otherwise return category
  if (category == "All") {
    return null;
  } else {
    return category;
  }
}

List<String> noRedundantCategories(List<String>? array) {
  // return an array of unique categories
  // create a set to store unique categories
  Set<String> uniqueCategories = {"All"};

  // loop through the array and add each category to the set
  if (array != null) {
    for (String category in array) {
      uniqueCategories.add(category);
    }
  }

  // convert the set back to a list and return it
  return uniqueCategories.toList();
}

List<CartGoodsStruct>? summarizeCart(List<GoodsRecord>? cart) {
  // merge items with the same description
  if (cart == null || cart.isEmpty) {
    return null;
  }

  final Map<String, CartGoodsStruct> summary = {};

  for (final item in cart) {
    final description = item.description;
    if (summary.containsKey(description)) {
      summary[description]!.quantity += 1;
      summary[description]!.price = item.price * summary[description]!.quantity;
    } else {
      summary[description] = CartGoodsStruct(
        description: description,
        quantity: 1,
        price: item.price * 1,
        previousQuantity: item.quantity,
      );
    }
  }

  return summary.values.toList();
}

int daysInt() {
  // how many days in this month
  DateTime now = DateTime.now();
  return now.day;
}

double? totalOfCart(List<GoodsRecord>? cart) {
  if (cart == null || cart.isEmpty) {
    return 0;
  }

  final Map<String, CartGoodsStruct> summary = {};

  for (final item in cart) {
    final description = item.description;
    if (summary.containsKey(description)) {
      summary[description]!.quantity += 1;
      summary[description]!.price = item.price * summary[description]!.quantity;
    } else {
      summary[description] = CartGoodsStruct(
        description: description,
        quantity: 1,
        price: item.price * 1,
      );
    }
  }

  final summarizedCart = summary.values.toList();

  double totalPrice = 0;
  for (final item in summarizedCart) {
    totalPrice += item.price;
  }
  return totalPrice;
}

DateTime? today() {
  // return today's date
  return DateTime.now();
}

String? cartToTextSummary(List<CartGoodsStruct>? cartGoods) {
  // summary the list into one multiline string
  if (cartGoods == null || cartGoods.isEmpty) {
    return null;
  }

  final summary = StringBuffer();

  for (final item in cartGoods) {
    summary.write('${item.description} x ${item.quantity}\n');
  }

  return summary.toString().trim();
}

double totalToRemit(List<TransactionsRecord>? transactions) {
  // Ensure that transactions is not null
  if (transactions == null) {
    return 0.0;
  }

  // Calculate the sum of the total of all transactions
  double total = 0.0;
  for (final transaction in transactions) {
    if (transaction.type == 'expense') {
      // Decrement the total for expense transactions
      if (transaction.goods.isEmpty) {
        total -= transaction.total;
      }
    } else {
      // Add the total for other types of transactions
      total += transaction.total;
    }
  }

  // Round the total to two decimal places and return it
  return double.parse(total.toStringAsFixed(2));
}

bool? moreThan12Hrs(DateTime? lastRemit) {
  // if current time is more than 12 hrs of lastRemit
  if (lastRemit == null) {
    return true;
  }
  final now = DateTime.now();
  final difference = now.difference(lastRemit).inHours;
  return difference > 12;
}

bool moreBeds(
  String startingBed,
  String widgetBed,
) {
  // turn both beds into int and compare if there are more beds
  int startingBedInt = int.parse(startingBed);
  int widgetBedInt = int.parse(widgetBed);

  return startingBedInt < widgetBedInt;
}

double sumOfGoodsIncome(List<TransactionsRecord> transactions) {
  //   // sum of each total of transactions with type book and goods
  double sum = 0.0;
  for (TransactionsRecord transaction in transactions) {
    if (transaction.type == 'goods') {
      sum += transaction.total;
    }
  }
  return sum;
}

String quantityDescriptionForBookings(
  String startingBeds,
  String currentBeds,
  int? startingNights,
  int? currentNights,
  int room,
  String lateCheckoutHours,
) {
  int bedsDifference =
      (int.tryParse(currentBeds) ?? 0) - (int.tryParse(startingBeds) ?? 0);
  int nightsDifference = (currentNights ?? 0) - (startingNights ?? 0);

  String bedsAction = (bedsDifference > 0) ? 'added' : 'removed';
  bedsDifference = bedsDifference.abs();

  String nightsAction = (nightsDifference > 0) ? 'extended' : 'refunded';
  nightsDifference = nightsDifference.abs();

  List<String> descriptions = [];

  if (bedsDifference > 0) {
    descriptions.add(
        '$bedsDifference ${bedsDifference == 1 ? 'bed' : 'beds'} $bedsAction');
  }

  if (nightsDifference > 0) {
    descriptions.add(
        '$nightsDifference ${nightsDifference == 1 ? 'night' : 'nights'} $nightsAction');
  }

  if (lateCheckoutHours != "0") {
    String pluralization = lateCheckoutHours == "1" ? 'hour' : 'hours';

    descriptions.add(
        'charged extra for checking out late for $lateCheckoutHours $pluralization');
  }

  String finalDescription = descriptions.isNotEmpty
      ? descriptions.join(' and ') + ' in room $room'
      : 'No changes';

  // Capitalize the first letter of the final description
  finalDescription = finalDescription.substring(0, 1).toUpperCase() +
      finalDescription.substring(1);

  return finalDescription;
}

bool hasDifferencesInBookings(
  String? startingBeds,
  int startingNights,
  int currentNights,
  String? currentBeds,
  bool lateCheckout,
) {
  int bedsDifference =
      int.tryParse(currentBeds ?? '0')! - int.tryParse(startingBeds ?? '0')!;
  int nightsDifference = currentNights - startingNights;

  return bedsDifference != 0 || nightsDifference != 0 || lateCheckout;
}

String dateWasChanged(
  DateTime prevDate,
  DateTime currDate,
  String description,
) {
  // The date was changed from _ to _.
  final DateFormat formatter = DateFormat('MMM d, yyyy');
  final String prevDateString = formatter.format(prevDate);
  final String currDateString = formatter.format(currDate);
  return 'The date associated with the bill named $description was modified from $prevDateString to $currDateString.';
}

int? prevOperatorChange(
  int prev,
  String operator,
  int change,
) {
  // if operator is add then add prev with change
  int absoluteChange = change.abs();

  switch (operator) {
    case 'add':
      return prev + absoluteChange;
    case 'minus':
      return prev - absoluteChange;
    case 'multiply':
      return prev * absoluteChange;
    default:
      return null;
  }
}

String whichOperator(
  int prev,
  int change,
) {
  // if change is higher than prev, return "add"
  if (change > prev) {
    return "add";
  } else if (prev > change) {
    return "minus";
  } else {
    return "equal";
  }
}

DateTime startOfDay(DateTime date) {
  // starting of date
  return DateTime(date.year, date.month, date.day);
}

DateTime endOfDay(DateTime date) {
  // end of date
  return DateTime(date.year, date.month, date.day, 23, 59, 59, 999, 999);
}

String activityAndPriceChange(
  String? activity,
  double prev,
  double current,
) {
  // if prev and current have changed, activity and "price changed"
  if (prev != current) {
    if (activity != null && activity.isNotEmpty) {
      return '$activity and changed price';
    } else {
      return 'changed price';
    }
  } else {
    return activity ?? '';
  }
}

String descriptionOfExpense(
  String whichExpense,
  String? consumedBy,
  String? reason,
) {
  switch (whichExpense) {
    case 'consumedBy':
      return 'consumed by ' +
          (consumedBy != null
              ? consumedBy
                  .split(' ')
                  .map((word) => word[0].toUpperCase() + word.substring(1))
                  .join(' ')
              : "Unknown");
    case 'spoilage':
      return 'spoiled';
    case 'other':
      return reason ?? 'Other expense';
    default:
      return 'invalid expense type';
  }
}

String startBigLetter(String text) {
  // start big letter
  if (text.isEmpty) {
    return text;
  }

  List<String> words = text.split(RegExp(r'\s+|\b(?=[()]|\b)'));
  List<String> capitalizedWords = [];

  for (int i = 0; i < words.length; i++) {
    String word = words[i];

    // Capitalize the first letter of each word
    if (word.isNotEmpty) {
      word = word[0].toUpperCase() + word.substring(1);
    }

    // Check for parenthesis and handle spaces
    if (word.startsWith('(') && i > 0 && !capitalizedWords.last.endsWith(' ')) {
      capitalizedWords[capitalizedWords.length - 1] += ' ';
    } else if (word.endsWith(')') &&
        i < words.length - 1 &&
        !words[i + 1].startsWith(')')) {
      word += ' ';
    }

    capitalizedWords.add(word);
  }

  // Join capitalized words into a single string
  String resultText = capitalizedWords.join(' ');

  // Define a regular expression to match spaces before periods and commas
  RegExp regex = RegExp(r' (?=[.,])');

  // Replace spaces before periods and commas with an empty string
  return resultText.replaceAll(regex, '');
}

double grossTransactions(List<TransactionsRecord> transactions) {
  //   // sum of each total of transactions with type book and goods
  double sum = 0.0;
  for (TransactionsRecord transaction in transactions) {
    if (transaction.type == 'book' ||
        transaction.type == 'goods' ||
        transaction.type == 'change') {
      sum += transaction.total;
    }
  }
  return sum;
}

double netOfTransactions(List<TransactionsRecord> transactions) {
  // sum of all transactions.total but minus all transactions.type expense
  double sum = 0.0;
  for (var transaction in transactions) {
    if (transaction.type == 'expense') {
      if (transaction.goods.isEmpty) {
        sum -= transaction.total;
      }
    } else {
      sum += transaction.total;
    }
  }
  return sum;
}

double sumOfExpenses(List<TransactionsRecord> transactions) {
  // sum of total of each transaction with type expense
  double total = 0.0;
  for (TransactionsRecord transaction in transactions) {
    if (transaction.type == 'expense') {
      if (transaction.goods.isEmpty) {
        total += transaction.total;
      }
    }
  }
  return total;
}

String netCircle(
  double gross,
  double expenses,
) {
  // how many percent is gross in the total of gross and expenses
  final double total = gross + expenses.abs();
  final double net = gross / total;
  final int percent = (net * 100).round();
  return '$percent%';
}

double netCircleDecimal(
  double gross,
  double expenses,
) {
  // percentage of gross in the total of gross and expenses
  double total = gross + expenses.abs();
  if (total == 0) {
    return 0.0;
  }
  return (gross / total);
}

String generateFortnight(DateTime date) {
  // Define the start of the year
  DateTime yearStart = DateTime(date.year, 1, 1);

  // Calculate the difference in days between the given date and the start of the year
  int dayDifference = date.difference(yearStart).inDays;

  // Calculate the fortnight
  int fortnight = (dayDifference ~/ 14) + 1;

  // Define a function to get the ordinal suffix
  String getOrdinalSuffix(int number) {
    if (number >= 11 && number <= 13) {
      return 'th';
    }
    int remainder = number % 10;
    switch (remainder) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  // Get the ordinal suffix for the fortnight
  String ordinalSuffix = getOrdinalSuffix(fortnight);

  // Return the result
  return '$fortnight$ordinalSuffix';
}

String downOrdinal(String ordinal) {
  // Decrement ordinal number by 1
  final int num = int.parse(ordinal.replaceAll(RegExp(r'\D'), ''));
  final int prevNum = num - 1;
  if (prevNum <= 0) {
    // Handle negative or zero ordinal numbers
    return ordinal;
  }
  final String suffix =
      (prevNum % 100 == 11 || prevNum % 100 == 12 || prevNum % 100 == 13)
          ? 'th'
          : (prevNum % 10 == 1)
              ? 'st'
              : (prevNum % 10 == 2)
                  ? 'nd'
                  : (prevNum % 10 == 3)
                      ? 'rd'
                      : 'th';
  return '$prevNum$suffix';
}

String upOrdinal(String ordinal) {
  // increment ordinal number by 1
  final int num = int.parse(ordinal.replaceAll(RegExp(r'\D'), ''));
  final int nextNum = num + 1;
  final String suffix =
      (nextNum % 100 == 11 || nextNum % 100 == 12 || nextNum % 100 == 13)
          ? 'th'
          : (nextNum % 10 == 1)
              ? 'st'
              : (nextNum % 10 == 2)
                  ? 'nd'
                  : (nextNum % 10 == 3)
                      ? 'rd'
                      : 'th';
  return '$nextNum$suffix';
}

double sumOfSalaries(List<SalariesRecord> salaries) {
  // sum the total of all salaries
  double total = 0.0;
  for (SalariesRecord salary in salaries) {
    total += salary.total;
  }
  return total;
}

double totalExpenses(List<TransactionsRecord> transactions) {
  // sum the total of each transaction type expense
  double total = 0.0;
  for (var transaction in transactions) {
    if (transaction.type == 'expense') {
      total += transaction.total;
    }
  }
  return total;
}

double sumOfRoomsIncome(List<TransactionsRecord> transactions) {
  //   // sum of each total of transactions with type book and goods
  double sum = 0.0;
  for (TransactionsRecord transaction in transactions) {
    if (transaction.type == 'book' || transaction.type == 'change') {
      sum += transaction.total;
    }
  }
  return sum;
}

double totalGoodsSales(List<TransactionsRecord> transactions) {
  // sum of total of transactions type goods
  double total = 0.0;
  for (TransactionsRecord transaction in transactions) {
    if (transaction.type == 'goods') {
      total += transaction.total;
    }
  }
  return total;
}

double totalBookedSales(List<TransactionsRecord> transactions) {
  // sum of total transactions type book
  double total = 0.0;
  for (TransactionsRecord transaction in transactions) {
    if (transaction.type == 'book') {
      total += transaction.total;
    }
  }
  return total;
}

double totalSalesLessExpenses(List<TransactionsRecord> transactions) {
  // sum of every total of each transactions minus transactions type expense
  double total = 0.0;
  for (var transaction in transactions) {
    if (transaction.type == 'expense') {
      total -= transaction.total;
    } else {
      total += transaction.total;
    }
  }
  return total;
}

double? calculateUnsettledCashAdvances(List<AdvancesRecord> cashAdvances) {
  // total of amount of every cash advance
  double totalAmount = 0.0;
  for (var cashAdvance in cashAdvances) {
    totalAmount += cashAdvance.amount;
  }
  return totalAmount;
}

double totalOfCAs(List<AdvancesRecord> advances) {
  // sum of amount of each advance
  double total = 0.0;
  for (var advance in advances) {
    total += advance.amount;
  }
  return total;
}

CurrentStatsStruct? currentMonthYear() {
  // return a currentstats with today's month and year
  CurrentStatsStruct currentStats = CurrentStatsStruct(
    month: DateFormat('MMMM').format(DateTime.now()),
    year: DateTime.now().year.toString(),
  );
  return currentStats;
}

List<String> listOfMonths() {
  // list of months
  return [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
}

String currentMonth() {
  // return today's month
  final now = DateTime.now();
  return DateFormat('MMMM').format(now);
}

List<String> listOfYears() {
  // list of years from 2023 until current year
  final currentYear = DateTime.now().year;
  final List<String> years = [];
  for (int i = 2023; i <= currentYear; i++) {
    years.add(i.toString());
  }
  return years;
}

String currentYear() {
  // return current year
  return DateTime.now().year.toString();
}

double transactionRoomIncomeTotal(TransactionsRecord transaction) {
  // return transaction.total for type book or change
  if (transaction.type == 'book') {
    return transaction.total;
  } else if (transaction.type == 'change') {
    return transaction.total;
  } else {
    return 0.0;
  }
}

double transactionGoodsTotal(TransactionsRecord transaction) {
  // return transaction.total only if type goods
  if (transaction.type == 'goods') {
    return transaction.total;
  } else {
    return 0.0;
  }
}

double transactionExpensesTotal(TransactionsRecord transaction) {
  // return transaction.total if type expense
  if (transaction.type == 'expense') {
    return transaction.total;
  } else {
    return 0.0;
  }
}

List<RoomUsageStruct> modifyRoomUsage(
  List<RoomUsageStruct> roomUsage,
  int room,
  int nights,
) {
  // Create a new list with modified RoomUsageStruct instances
  List<RoomUsageStruct> modifiedRoomUsage =
      List<RoomUsageStruct>.from(roomUsage);

  // Find the index of the RoomUsageStruct with the specified room number
  int index = modifiedRoomUsage.indexWhere((ru) => ru.number == room);

  if (index != -1) {
    // If a matching RoomUsageStruct was found, increment its use with nights
    modifiedRoomUsage[index] = RoomUsageStruct(
      number: room,
      use: modifiedRoomUsage[index].use + nights,
    );
  }

  return modifiedRoomUsage;
}

double progressRoomUsage(
  List<RoomUsageStruct> list,
  RoomUsageStruct room,
) {
  double maxUtilization = 0;
  for (var roomUsage in list) {
    if (roomUsage.use > maxUtilization) {
      maxUtilization = roomUsage.use.toDouble();
    }
  }

  // Find the room to compare
  RoomUsageStruct roomToCompare =
      list.firstWhere((roomUsage) => roomUsage.number == room.number);

  if (maxUtilization == 0) {
    // Return 0% if the max utilization is 0
    return 0.0;
  }

  // Calculate the percentage of the room's utilization relative to the max utilization
  double utilizationPercentage = roomToCompare.use / maxUtilization;

  return utilizationPercentage <= 1.0 ? utilizationPercentage : 1.0;
}

int? daysInTodaysMonth() {
  // how many days in this month
  DateTime now = DateTime.now();
  int days = DateTime(now.year, now.month + 1, 0).day;
  return days;
}

LineGraphStruct initEmptyLineGraph() {
  // initialize empty xData and yData integer lists
  return LineGraphStruct(xData: [], yData: []);
}

LineGraphStruct newLineGraph(
  double income,
  LineGraphStruct lineGraph,
) {
  // Add new items of xData which is today's day, and yData which is income but int
  final now = DateTime.now();
  final day = now.day;

  // Create copies of existing xData and yData
  final updatedXData = List<int>.from(lineGraph.xData);
  final updatedYData = List<int>.from(lineGraph.yData);

  int index = updatedXData.indexOf(day);

  if (index != -1 && index < updatedYData.length) {
    // Day already exists, increment the income in the corresponding element of updatedYData
    updatedYData[index] += income.toInt();
  } else {
    // Day doesn't exist, add the new data points
    updatedXData.add(day);
    updatedYData.add(income.toInt());
  }

  return LineGraphStruct(
    xData: updatedXData,
    yData: updatedYData,
  );
}

double priceHasChanged(
  double total,
  double changedTotal,
) {
  // if changedTotal is lesser then total the difference is negative, otherwise positive
  double difference = total - changedTotal;
  if (changedTotal < total) {
    return -1 * difference;
  } else {
    return difference.abs();
  }
}

int quantityBasedOnCart(
  List<GoodsRecord>? cart,
  GoodsRecord good,
) {
  // how many times good.description inside cart item.description
  int count = 0;
  if (cart != null) {
    for (var item in cart) {
      if (item.description.contains(good.description)) {
        count += 1;
      }
    }
  }
  // Subtract count from good.quantity
  int adjustedQuantity = good.quantity - count;

  // Ensure the result is non-negative
  return math.max(0, adjustedQuantity);
}

List<bool> showUnremittedOnlyIfNotAdmin(String role) {
  // if admin role give both, otherwise only false
  if (role == 'admin') {
    return [true, false];
  } else {
    return [false];
  }
}

List<String> intListToStringList(List<int> numbers) {
  // int list to string list typecast
  return numbers.map((number) => number.toString()).toList();
}

int indexOfRoomInRoomUsage(
  List<RoomUsageStruct> roomUsage,
  int room,
) {
  int index = roomUsage.indexWhere((ru) => ru.number == room);
  return index;
}

String changesToBookingTransaction(
  String prevDesc,
  String currentDesc,
  String prevPrice,
  String currentPrice,
) {
  List<String> changes = [];

  if (prevDesc != currentDesc) {
    changes.add("Description has changed from '$prevDesc' to '$currentDesc'.");
  }

  if (prevPrice != currentPrice) {
    changes.add("Price has changed from '$prevPrice' to '$currentPrice'.");
  }

  if (changes.isEmpty) {
    return "No changes detected but transaction was attempted to be edited.";
  } else {
    return changes.join(' ');
  }
}

String roomUpdateHistoryDescription(
  int prevNumber,
  double prevPrice,
  int prevCapacity,
  int currentNumber,
  double currentPrice,
  int currentCapacity,
) {
  List<String> changes = [];

  if (prevNumber != currentNumber) {
    changes.add("Number changed from $prevNumber to $currentNumber.");
  }

  if (prevPrice != currentPrice) {
    changes.add("Price changed from $prevPrice to $currentPrice.");
  }

  if (prevCapacity != currentCapacity) {
    changes.add("Capacity changed from $prevCapacity to $currentCapacity.");
  }

  if (changes.isEmpty) {
    return "No changes detected, but there was an attempt to change the details of this room.";
  } else {
    return changes.join(' ');
  }
}

DateTime startOfMonth(
  String month,
  String year,
) {
  // starting time of the given month only
  final selectedMonth = DateFormat('MMMM').parse(month).month;
  return DateTime(int.parse(year), selectedMonth, 1);
}

List<StaffsRecord> staffsToAddSalary(
  List<StaffsRecord> staffs,
  List<SalariesRecord> salaries,
) {
  // staffs not found in salary.staff
  final staffsWithoutSalary = <StaffsRecord>[];
  for (final staff in staffs) {
    final hasSalary = salaries.any((salary) => salary.staff == staff.reference);
    if (!hasSalary) {
      staffsWithoutSalary.add(staff);
    }
  }
  return staffsWithoutSalary;
}

double updateSalaryTotal(
  bool rateSet,
  bool sssSet,
  double oldRate,
  double? newRate,
  double oldSSS,
  double? newSSS,
  double ca,
  double absences,
) {
  final rate = rateSet ? newRate! : oldRate;
  final sss = oldSSS == 0 ? 0 : (sssSet ? newSSS! : oldSSS);

  final total = rate - sss - ca - absences;
  return total;
}

List<RoomUsageStruct> highestRoomUtilityOrderUsage(
    List<RoomUsageStruct> roomUsage) {
  // sort by roomUsage.use descending
  roomUsage.sort((a, b) => b.use.compareTo(a.use));
  return roomUsage;
}

List<TransactionsRecord> sortTransactionDescending(
    List<TransactionsRecord> transactions) {
  // sort transaction.date descending
  transactions.sort((a, b) => b.date!.compareTo(a.date!));
  return transactions;
}

String resetFont(String text) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: 'Outfit', // Set the desired font family
    ),
  ).data!;
}

DateTime prevDate(DateTime date) {
  // previous day of date
  return date.subtract(Duration(days: 1));
}

DateTime nextDate(DateTime date) {
  // next day of date
  return date.add(Duration(days: 1));
}

String modifyTransactionRoomDescription(
  String prevDesc,
  String newRoom,
  String oldRoom,
) {
  // change text inside prevDesc Room $oldRoom to Room $newRoom
  return prevDesc.replaceAll('room $oldRoom', 'room $newRoom');
}

double avgYData(List<int> sales) {
  if (sales.isEmpty) {
    return 0.0;
  }

  if (sales.length == 1) {
    return sales.first.toDouble();
  }

  int partitionCount = ((sales.length - 1) / 3).ceil();
  sales.sort();

  // Determine partition ranges
  int minValue = sales.first;
  int maxValue = sales.last;
  int rangeSize = ((maxValue - minValue) / partitionCount).ceil();

  // Create partitions
  List<List<int>> partitions = List.generate(
    partitionCount,
    (index) {
      int start = minValue + index * rangeSize;
      int end = index == partitionCount - 1 ? maxValue : start + rangeSize - 1;
      return [start, end];
    },
  );

  // Assign sales values to partitions
  List<int> partitionCounts = List.filled(partitionCount, 0);

  for (int sale in sales) {
    for (int i = 0; i < partitionCount; i++) {
      if (sale >= partitions[i][0] && sale <= partitions[i][1]) {
        partitionCounts[i]++;
        break;
      }
    }
  }

  // Find the partition with the most sales
  int maxPartitionIndex =
      partitionCounts.indexOf(partitionCounts.reduce((a, b) => a > b ? a : b));

  // Filter sales values in the winning partition
  List<int> winningPartitionSales = sales
      .where((sale) =>
          sale >= partitions[maxPartitionIndex][0] &&
          sale <= partitions[maxPartitionIndex][1])
      .toList();

  // Calculate the average of the winning partition
  double averageWinningPartition =
      winningPartitionSales.reduce((a, b) => a + b) /
          winningPartitionSales.length;

  // Calculate the overall average of all sales
  double averageAllSales = sales.reduce((a, b) => a + b) / sales.length;

  // Adjust the result to be closer to the average of all sales
  double adjustedAverage = (averageWinningPartition + averageAllSales) / 2;

  return adjustedAverage;
}

LineGraphStruct mergedLine(
  LineGraphStruct serenity,
  LineGraphStruct myLifestyle,
) {
  // if the same xData [int], merge by adding the yData [int]
  Map<int, int> mergedData = {};

// Add serenity data to mergedData
  for (int i = 0; i < serenity.xData.length; i++) {
    int x = serenity.xData[i];
    int y = serenity.yData[i];
    mergedData[x] = y;
  }

// Add myLifestyle data to mergedData
  for (int i = 0; i < myLifestyle.xData.length; i++) {
    int x = myLifestyle.xData[i];
    int y = myLifestyle.yData[i];
    if (mergedData.containsKey(x)) {
      mergedData[x] = (mergedData[x] ?? 0) + y;
    } else {
      mergedData[x] = y;
    }
  }

// Convert mergedData to LineGraphStruct format
  List<int> xData = [];
  List<int> yData = [];
  mergedData.forEach((x, y) {
    xData.add(x);
    yData.add(y);
  });

  return LineGraphStruct(xData: xData, yData: yData);
}

List<RoomUsageStruct> extractRoomUsage(StatsRecord stats) {
  // extract roomUsage from  stats

  return stats.roomUsage!;
}

bool findTextsInString(
  String? source,
  String textsToFind,
) {
  // if either any of these texts possibly separated by comma is equal the source
  if (source == null) {
    return false;
  }
  final List<String> texts = textsToFind.split(',');
  for (final text in texts) {
    if (source.contains(text.trim())) {
      return true;
    }
  }
  return false;
}

double calculateAbsencesTotal(List<AbsencesRecord> absences) {
  double totalAmount = 0.0;
  for (var absent in absences) {
    if (!absent.settled) {
      totalAmount += absent.amount;
    }
  }
  return totalAmount;
}

String activityOfInventory(
  double prevPrice,
  double currentPrice,
  int prevQuantity,
  int currentQuantity,
  String prevDescription,
  String currentDescription,
  String prevCategory,
  String currentCategory,
) {
  // if any of the prev and current are changed, return what type of activity
  List<String> activities = [];

  if (prevPrice < currentPrice) {
    activities.add('increased price');
  } else if (prevPrice > currentPrice) {
    activities.add('decreased price');
  }

  if (prevCategory != currentCategory) {
    activities.add('revised category');
  }

  if (prevQuantity < currentQuantity) {
    activities.add(prevQuantity == 0 ? 'replenished' : 'added more');
  } else if (prevQuantity > currentQuantity) {
    activities.add('removed some');
  }

  if (prevDescription != currentDescription) {
    activities.add('revised description');
  }

  return activities.isNotEmpty
      ? activities.join(' and ')
      : 'nothing was changed';
}

String howManyItems(List<CartGoodsStruct> goods) {
  // sum of all good.quantity
  int sum =
      goods.fold(0, (int acc, CartGoodsStruct item) => acc + item.quantity);
  String pluralSuffix = sum == 1 ? " item" : " items";
  return "$sum$pluralSuffix sold";
}

int indexOfStatsFromHotel(
  List<StatsRecord> stats,
  String hotel,
) {
  // which stats contain hotel
  for (int i = 0; i < stats.length; i++) {
    if (stats[i].hotel == hotel) {
      return i;
    }
  }
  return -1;
}

String? numOfGuests(String guests) {
  // if guests is 0, return No Guests, if 1,1 Guest, if 2 or many, $guests Guests
  int numGuests = int.tryParse(guests) ?? 0;
  if (numGuests == 0) {
    return 'No Guests';
  } else if (numGuests == 1) {
    return '1 Guest';
  } else {
    return '$numGuests Guests';
  }
}

double add(
  double xx,
  double yy,
) {
  // add xx and yy
  return xx + yy;
}

int daysFrom(DateTime date) {
  // how many days it has been since
  final now = DateTime.now();
  final difference = now.difference(date);
  return difference.inDays;
}

String daysOfIssue(
  DateTime date,
  DateTime? dateFixed,
) {
  final now = DateTime.now();
  final days = now.difference(date).inDays.abs();
  final suffix = days == 1 ? ' day' : ' days';
  return '$days$suffix ${days > 0 ? "ago" : "from now"}';
}

List<RoomPendingStruct>? allPendings(List<TransactionsRecord>? transactions) {
  // combine all same booking transaction.booking and increment total, booking.toString() as key
  if (transactions == null || transactions.isEmpty) {
    return [];
  }

  final Map<String, RoomPendingStruct> pendingMap = {};

  for (final transaction in transactions) {
    final booking = transaction.booking.toString();
    if (pendingMap.containsKey(booking)) {
      final pending = pendingMap[booking]!;
      pending.total += transaction.total;
      pending.since = transaction.date!.isAfter(pending.since!)
          ? transaction.date
          : pending.since;
    } else {
      final pending = RoomPendingStruct(
        booking: transaction.booking,
        room: transaction.room,
        total: transaction.total,
        since: transaction.date,
      );
      pendingMap[booking] = pending;
    }
  }

  return pendingMap.values.toList();
}

bool isInventoryComplete(
  List<TransactionsRecord> transactions,
  List<InventoriesRecord> inventories,
) {
  // all transactions that has goods also match with inventory

  // Then, we iterate through each transaction and check if all its goods are in the inventory map
  for (final transaction in transactions) {
    if (transaction.type != "book" && transaction.type != "change") {
      if (transaction.goods != null) {
        for (final good in transaction.goods) {
          // Check if there is a corresponding item in the inventories list
          bool hasCorrespondingItem = inventories.any(
            (inventory) => inventory.item == good.description,
          );

          // If there is no corresponding item, the inventory is not complete
          if (!hasCorrespondingItem) {
            return false;
          }
        }
      }
    }
  }

  // If all goods in all transactions are in the inventory map with sufficient quantities, then the inventory is complete
  return true;
}

String previousMonth(String currentMonth) {
  // Parse the current month string
  DateTime currentMonthDate = DateFormat('MMMM').parse(currentMonth);

  // Subtract one month to get the previous month
  DateTime previousMonthDate = currentMonthDate.subtract(Duration(days: 1));

  // Format the result to return the month name
  String previousMonthName = DateFormat('MMMM').format(previousMonthDate);

  return previousMonthName;
}

String previousYear(
  String currentMonth,
  String currentYear,
) {
  // Parse the current month and year strings
  DateTime currentDate =
      DateFormat('MMMM yyyy').parse('$currentMonth $currentYear');

  // Subtract one month to get the previous month
  DateTime previousDate = currentDate.subtract(Duration(days: 1));

  // Extract the previous year and format it as a string
  String previousYear = DateFormat('yyyy').format(previousDate);

  return previousYear;
}

StatsRecord statByHotel(
  List<StatsRecord> stats,
  String hotel,
) {
  // return stat that has state.hotel == hotel
  return stats.firstWhere((stat) => stat.hotel == hotel);
}

String nextYear(
  String year,
  String month,
) {
  if (month == 'December') {
    // If the current month is December, increment the year
    return (int.parse(year) + 1).toString();
  } else {
    // If it's not December, return the same year
    return year;
  }
}

String nextMonth(String currentMonth) {
  // List of month names
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  // Find the index of the current month
  int currentMonthIndex = months.indexOf(currentMonth);

  // Move to the next index (circularly) to get the next month
  int nextMonthIndex = (currentMonthIndex + 1) % months.length;

  // Get the next month name
  String nextMonthName = months[nextMonthIndex];

  return nextMonthName;
}

List<RoomUsageStruct> refreshRoomsInStats(
  List<RoomUsageStruct> currentRoomUsages,
  List<RoomsRecord> rooms,
) {
  // if  currentRoomUsage.number doesn't have room.number, add it to list
  final List<RoomUsageStruct> updatedRoomUsages = [...currentRoomUsages];
  for (final RoomsRecord room in rooms) {
    final bool hasRoom =
        updatedRoomUsages.any((ru) => ru.number == room.number);
    if (!hasRoom) {
      updatedRoomUsages.add(RoomUsageStruct(
        number: room.number,
        use: 0,
      ));
    }
  }
  return updatedRoomUsages;
}

double stringToDouble(String text) {
  // string to double
  return double.tryParse(text) ?? 0.0;
}

TransactionsRecord? transactionWithMissingInventory(
  List<TransactionsRecord> transactions,
  List<InventoriesRecord> inventories,
) {
  // Then, we iterate through each transaction and check if all its goods are in the inventory map
  for (final transaction in transactions) {
    if (transaction.type != "book" && transaction.type != "change") {
      if (transaction.goods != null) {
        for (final good in transaction.goods) {
          // Check if there is a corresponding item in the inventories list
          bool hasCorrespondingItem = inventories.any(
            (inventory) => inventory.item == good.description,
          );

          // If there is no corresponding item, the inventory is not complete
          if (!hasCorrespondingItem) {
            return transaction;
          }
        }
      }
    }
  }
  return transactions[0];
}

bool goodThatCannotBeFoundInInventory(
  List<InventoriesRecord> inventories,
  CartGoodsStruct good,
) {
  // is the good.description found in inventory.item?
  for (final inventory in inventories) {
    if (inventory.item == good.description) {
      return false;
    }
  }
  return true;
}

String daysAgo(DateTime date) {
  // how many days ago since date
  final now = DateTime.now();
  final difference = now.difference(date).inDays;
  if (difference == 0) {
    return 'Today';
  } else if (difference == 1) {
    return 'Yesterday';
  } else {
    return '$difference days ago';
  }
}

DateTime? dayBefore(DateTime date) {
  // day before date in start hour on 0:00
  final dayBefore = date.subtract(Duration(days: 1));
  return DateTime(dayBefore.year, dayBefore.month, dayBefore.day, 0, 0);
}

String metricChange(
  double currentValue,
  String type,
  List<MetricsHolderStruct> metrics,
  String hotel,
) {
  // Helper function to get the value of a specific metric type
  double getMetricValue(MetricsHolderStruct metric, String type) {
    switch (type) {
      case 'rooms':
        return metric.rooms;
      case 'expenses':
        return metric.expenses;
      case 'goods':
        return metric.goods;
      case 'salaries':
        return metric.salaries;
      case 'bills':
        return metric.bills;
      case 'net':
        return metric.net;
      default:
        return 0.0; // Default to 0.0 if the type is not recognized
    }
  }

  // Helper function to calculate percentage change
  String calculatePercentageChange(
      double currentValue, double comparisonValue) {
    if (comparisonValue != 0.0) {
      double percentageChange =
          ((currentValue - comparisonValue) / comparisonValue) * 100;
      int roundedPercentageChange =
          percentageChange.round(); // Round to the nearest integer
      return '$roundedPercentageChange%';
    } else {
      return 'N/A'; // Avoid division by zero, handle it as needed
    }
  }

  // Filter metrics based on type
  var relevantMetrics =
      metrics.where((metric) => metric.hotel == hotel || hotel == 'All');

  // Check if relevantMetrics is empty
  if (relevantMetrics.isEmpty) {
    return 'N/A';
  }

  // If hotel is not 'All', find the specific metric with the same hotel
  if (hotel != 'All') {
    var specificMetric =
        relevantMetrics.firstWhere((metric) => metric.hotel == hotel);

    double specificMetricValue = getMetricValue(specificMetric, type);
    return calculatePercentageChange(currentValue, specificMetricValue);
  } else {
    // If hotel is 'All', get the sum of the metrics of the same type
    double sumMetricsValue = relevantMetrics.fold(
        0.0, (sum, metric) => sum + getMetricValue(metric, type));
    return calculatePercentageChange(currentValue, sumMetricsValue);
  }

  // If no relevant metrics found, return an appropriate message or handle it as needed
  return 'N/A';
}

DateTime endOfMonth(
  String month,
  String year,
) {
  // end of month which is MMMM
  final nextYear =
      month == "December" ? (int.parse(year) + 1).toString() : year;

  final Map<String, int> monthMap = {
    'January': 1,
    'February': 2,
    'March': 3,
    'April': 4,
    'May': 5,
    'June': 6,
    'July': 7,
    'August': 8,
    'September': 9,
    'October': 10,
    'November': 11,
    'December': 12,
  };

  final firstDayOfNextMonth = DateTime.utc(
    int.parse(nextYear),
    monthMap[month]! + 1,
    1,
  );
  final lastDayOfMonth = firstDayOfNextMonth.subtract(Duration(days: 1));

  return lastDayOfMonth;
}

double sumOfBills(List<BillsRecord> bills) {
  // sum of bills amount
  double sum = 0.0;
  for (var bill in bills) {
    sum += bill.amount;
  }
  return sum;
}

bool isThisMonth(DateTime date) {
  // is the date this month?
  final now = DateTime.now();
  return date.year == now.year && date.month == now.month;
}

String hoursAgo(DateTime date) {
  // how many minutes and hours ago
  final now = DateTime.now();
  final difference = now.difference(date);
  final hours = difference.inHours;
  final minutes = difference.inMinutes.remainder(60);
  if (hours > 0) {
    return '$hours hour${hours > 1 ? 's' : ''} ago';
  } else {
    return '$minutes minute${minutes > 1 ? 's' : ''} ago';
  }
}

double? adjustPrice(
  String operator,
  double original,
  String? adjustment,
) {
  if (adjustment == null) {
    return original;
  }

  // return original operator (+/-) adjustment.toDouble
  if (operator == '+') {
    return original + double.tryParse(adjustment)!;
  } else if (operator == '-') {
    return original - double.tryParse(adjustment)!;
  } else {
    return original;
  }
}

String daysSolved(
  DateTime date,
  DateTime? dateFixed,
) {
  // days from date if dateFixed is set, then days from date to dateFixed
  if (dateFixed != null) {
    final days = dateFixed.difference(date).inDays.abs() + 1;
    final suffix = days == 1 ? ' day' : ' days';
    return '($days$suffix)';
  } else {
    return '';
  }
}

List<String> billsChoices(List<String>? descriptions) {
  // Initialize a map to count occurrences of each description
  final Map<String, int> descriptionCount = {};

  // Count occurrences of each description
  if (descriptions != null) {
    for (final description in descriptions) {
      descriptionCount[description] = (descriptionCount[description] ?? 0) + 1;
    }
  }

  // Filter descriptions with more than one occurrence
  final filteredDescriptions =
      descriptionCount.entries.where((entry) => entry.value > 1).toList();

  // Sort filtered descriptions by their occurrences in descending order
  filteredDescriptions.sort((a, b) => b.value.compareTo(a.value));

  // Extract sorted descriptions
  final sortedUniqueDescriptions =
      filteredDescriptions.map((entry) => entry.key).toList();

  // Add "All" at the beginning of the list
  sortedUniqueDescriptions.insert(0, 'All');

  return sortedUniqueDescriptions;
}

List<TransactionsRecord> mergeTransactions(
  List<TransactionsRecord> transactionsWhole,
  List<TransactionsRecord> transactionsFirstDayOfMonth,
) {
  // merge transactionsFirstDayOfMonth should not already be in transactionsWhole
  final Set<String> transactionIds =
      transactionsWhole.map((t) => t.reference.id).toSet();
  final List<TransactionsRecord> mergedTransactions =
      List.from(transactionsWhole);
  for (final transaction in transactionsFirstDayOfMonth) {
    if (!transactionIds.contains(transaction.reference.id)) {
      mergedTransactions.add(transaction);
    }
  }
  return mergedTransactions;
}

double pendingsTotal(List<TransactionsRecord>? transactions) {
  // combine all same booking transaction.booking and increment total, booking.toString() as key
  if (transactions == null || transactions.isEmpty) {
    return 0.0; // Return 0.0 for empty or null transactions
  }

  double total = 0.0; // Initialize total sum

  for (final transaction in transactions) {
    total += transaction.total;
  }

  return total; // Return the sum of transaction.total values
}

double absolute(double amount) {
  // just turn the amount to absolute
  return amount.abs();
}

String changesInBillDescription(
  String? prevDesc,
  String? currDesc,
  double? prevAmount,
  double? currAmount,
) {
  // Check if there are no changes
  if (prevDesc == currDesc && prevAmount == currAmount) {
    return 'There are no changes.';
  }

  // Build the change description
  String changeDesc = '';

  // Check for description change
  if (prevDesc != currDesc) {
    changeDesc +=
        'Description changed from ${prevDesc ?? 'null'} to ${currDesc ?? 'null'}';
  }

  // Check for amount change
  if (prevAmount != currAmount) {
    if (changeDesc.isNotEmpty) {
      changeDesc += ', ';
    }
    changeDesc +=
        'Amount changed from ${prevAmount?.toStringAsFixed(2) ?? 'null'} to ${currAmount?.toStringAsFixed(2) ?? 'null'}';
  }

  return changeDesc;
}

String monthWasChanged(
  DateTime prevDate,
  DateTime currDate,
  String description,
) {
  final DateFormat formatter = DateFormat('MMMM');
  final String prevMonth = formatter.format(prevDate);
  final String currMonth = formatter.format(currDate);
  return 'The date linked to the bill titled $description was shifted from the records of $prevMonth to $currMonth.';
}

List<IssuesRecord>? sortIssueDesc(List<IssuesRecord>? issues) {
  // sort issue.date descending
  if (issues == null || issues.isEmpty) {
    return null;
  }
  issues.sort((a, b) => b.date!.compareTo(a.date!));
  return issues;
}

DateTime startOfYear(String year) {
  // start of year
  return DateTime(int.parse(year), 1, 1);
}

DateTime endOfYear(String year) {
  // end of year
  return DateTime(int.parse(year), 12, 31, 23, 59, 59, 999);
}

double totalOfSpecificBill(List<BillsRecord>? bills) {
  // total of bill.amount
  double total = 0.0;
  if (bills != null) {
    for (var bill in bills) {
      total += bill.amount ?? 0.0;
    }
  }
  return total;
}

DateTime dayFromNow() {
  // subtract 24 hours from now
  return DateTime.now().subtract(Duration(hours: 24));
}

int pendingsLastTwentyFourHours(List<TransactionsRecord>? transactions) {
  if (transactions == null || transactions.isEmpty) {
    return 0; // Return 0 if transactions are null or empty
  }

  final Map<String, RoomPendingStruct> pendingMap = {};

  for (final transaction in transactions) {
    final booking = transaction.booking.toString();
    if (pendingMap.containsKey(booking)) {
      final pending = pendingMap[booking]!;
      pending.total += transaction.total;
      pending.since = transaction.date!.isAfter(pending.since!)
          ? transaction.date
          : pending.since;
    } else {
      final pending = RoomPendingStruct(
        booking: transaction.booking,
        room: transaction.room,
        total: transaction.total,
        since: transaction.date,
      );
      pendingMap[booking] = pending;
    }
  }

  // Print the hours ago of the mostRecentDate
  final now = DateTime.now();
  final lastTwentyFourHours = now.subtract(Duration(hours: 24));
  final mostRecentDate = pendingMap.values
      .map((pending) => pending.since)
      .reduce((value, element) => value!.isAfter(element!) ? value : element);

  // Count the number of mostRecentDate instances in the pendingMap
  int countMostRecentDate = 0;
  for (final pending in pendingMap.values) {
    if (pending.since != null && pending.since!.isBefore(lastTwentyFourHours)) {
      countMostRecentDate++;
    }
  }
  return countMostRecentDate;
}

List<HistoryRecord>? sortRoomHistoryASC(List<HistoryRecord>? history) {
  // sort history.date ascending
  if (history == null || history.isEmpty) {
    return null;
  }
  history.sort((a, b) => a.date!.compareTo(b.date!));
  return history;
}
