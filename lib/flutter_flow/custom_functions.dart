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
  // return yesterday since 2pm utc 8
  final now = DateTime.now().toUtc();
  final yesterday = now.subtract(Duration(days: 1));
  final yesterday2pm =
      DateTime.utc(yesterday.year, yesterday.month, yesterday.day, 14);
  return yesterday2pm;
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
      total -= transaction.total;
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

int sumOfGoodsIncome(List<TransactionsRecord> transactions) {
  //   // sum of each total of transactions with type book and goods
  double sum = 0.0;
  for (TransactionsRecord transaction in transactions) {
    if (transaction.type == 'goods') {
      sum += transaction.total;
    }
  }
  return sum.toInt();
}

String quantityDescriptionForBookings(
  String startingBeds,
  String currentBeds,
  int? startingNights,
  int? currentNights,
  int room,
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

  return descriptions.isNotEmpty
      ? descriptions.join(' and ') + ' in room $room'
      : 'No changes';
}

bool hasDifferencesInBookings(
  String? startingBeds,
  int startingNights,
  int currentNights,
  String? currentBeds,
) {
  int bedsDifference =
      int.tryParse(currentBeds ?? '0')! - int.tryParse(startingBeds ?? '0')!;
  int nightsDifference = currentNights - startingNights;

  return bedsDifference != 0 || nightsDifference != 0;
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
      return 'consumed by ${consumedBy ?? "unknown"}';
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
  return text[0].toUpperCase() + text.substring(1);
}

double grossTransactions(List<TransactionsRecord> transactions) {
  //   // sum of each total of transactions with type book and goods
  double sum = 0.0;
  for (TransactionsRecord transaction in transactions) {
    if (transaction.type == 'book' || transaction.type == 'goods') {
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
      sum -= transaction.total;
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
      total += transaction.total;
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

int sumOfRoomsIncome(List<TransactionsRecord> transactions) {
  //   // sum of each total of transactions with type book and goods
  double sum = 0.0;
  for (TransactionsRecord transaction in transactions) {
    if (transaction.type == 'book' || transaction.type == 'change') {
      sum += transaction.total;
    }
  }
  return sum.toInt();
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
  int totalUsage = list.fold(0, (sum, roomUsage) => sum + roomUsage.use);

  // Find the room to compare
  RoomUsageStruct roomToCompare =
      list.firstWhere((roomUsage) => roomUsage.number == room.number);

  if (roomToCompare.use == 0) {
    // Return 0% if the room to compare has not been used
    return 0.0;
  }

  // Calculate the average usage of other rooms
  int otherRoomsTotalUsage = totalUsage - roomToCompare.use;
  double averageUsage = otherRoomsTotalUsage / (list.length - 1);

  // Calculate the utilization percentage based on the average
  double utilizationPercentage = (roomToCompare.use / averageUsage);

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

  // Add the new data points
  updatedXData.add(day);
  updatedYData.add(income.toInt());

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
