// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:math';

class PrintRemittance extends StatefulWidget {
  const PrintRemittance({
    Key? key,
    this.width,
    this.height,
    required this.remittance,
    this.transactions,
    this.inventories,
    this.hotel,
    this.bookings,
    required this.rooms,
    this.preparedBy,
    this.collectedBy,
  }) : super(key: key);

  final double? width;
  final double? height;
  final RemittancesRecord remittance;
  final List<TransactionsRecord>? transactions;
  final List<InventoriesRecord>? inventories;
  final String? hotel;
  final List<BookingsRecord>? bookings;
  final List<RoomsRecord> rooms;
  final String? preparedBy;
  final String? collectedBy;

  @override
  _PrintRemittanceState createState() => _PrintRemittanceState();
}

class _PrintRemittanceState extends State<PrintRemittance> {
  late String formattedDate;
  late double roomSales; // Declare roomSales as an instance variable

  @override
  void initState() {
    super.initState();
    formattedDate =
        DateFormat('EEEE MMMM d y h:mm a').format(widget.remittance.date!);
    roomSales = 0.0;
  }

  String generateExpenseDescription(TransactionsRecord transaction) {
    final goodsDescription = transaction.goods.isEmpty
        ? transaction.description
        : transaction.goods
                .map((goodsItem) =>
                    '${goodsItem.description} x${goodsItem.quantity.toString()}')
                .join(', ') +
            (transaction.description.isNotEmpty
                ? ' - ${transaction.description}' +
                    ' - excluded from total expenses'
                : '');

    return goodsDescription;
  }

  Future<void> generatePdf() async {
    final pdf = pw.Document();

    List<List<String>> generateRoomTableData() {
      final List<List<String>> entries = [];
      int totalNights = 0;

      widget.rooms.sort((a, b) => a.number.compareTo(b.number));

      for (final room in widget.rooms) {
        final List<String> entry = [];
        entry.add('Room ${room.number}');

        // Find bookings for the current room
        final roomBookings = widget.bookings
                ?.where((booking) => booking.room == room.reference)
                .toList() ??
            [];

        // Find transactions related to the room
        final bookTransactions = widget.transactions
                ?.where((transaction) => transaction.room == room.number)
                .toList() ??
            [];

        roomSales += bookTransactions.isNotEmpty
            ? bookTransactions.fold(
                0.0, (sum, transaction) => sum + transaction.total)
            : 0.0;

        final double total = bookTransactions.isNotEmpty
            ? double.parse((bookTransactions.fold(
                0.0, (sum, transaction) => sum + transaction.total)).toString())
            : 0.0;

        final String totalText = bookTransactions.isNotEmpty
            ? NumberFormat.currency(
                symbol: 'Php ',
                decimalDigits: 2,
              ).format(total)
            : room.vacant
                ? 'vacant'
                : 'still occupied';
        // Room Price
        entry.add(NumberFormat.currency(
          symbol: 'Php ',
          decimalDigits: 2,
        ).format(room.price));
        // Amount Paid
        entry.add(totalText);
        Set<String> uniqueBookingReferences = Set<String>();
        entry.add(roomBookings.isNotEmpty
            ? roomBookings.fold(0, (sum, booking) {
                if (!uniqueBookingReferences.contains(booking.reference.path)) {
                  uniqueBookingReferences.add(booking.reference.path);
                  totalNights += booking.nights; // Update totalNights here
                  return sum + booking.nights;
                }
                return sum;
              }).toString()
            : '0');

        entries.add(entry);
      }

      // Add total entry
      entries.add([
        'Total',
        "",
        NumberFormat.currency(
          symbol: 'Php ',
          decimalDigits: 2,
        ).format(roomSales),
        '$totalNights nights',
      ]);

      return entries;
    }

    // Data for the table
    final roomTableData = [
      ...generateRoomTableData(),
    ];

    // Split the data into two parts
    final int halfLength = (roomTableData.length / 2).ceil();
    final List<List<String>> firstHalf = roomTableData.sublist(0, halfLength);
    final List<List<String>> secondHalf = [
      ...roomTableData.sublist(halfLength),
    ];

    // Add a helper method to safely convert double to int
    int? safeToInt(double? value) {
      return value?.toInt();
    }

    List<List<String>> generateGoodsTableData() {
      final List<List<String>> entries = [];
      final Map<String, Map<String, double>> goodsData = {};

      final Map<String, double> totals = {
        'Quantity Sold': 0.0,
        'Starting Quantity': 0.0,
        'Remaining Quantity': 0.0,
        'Total': 0.0,
      };

      // Filter transactions to get only those with type "goods"
      final goodsTransactions = widget.transactions
              ?.where((transaction) => transaction.type == 'goods')
              .toList() ??
          [];
      // Process each goods transaction
      for (final transaction in goodsTransactions) {
        for (final goodsItem in transaction.goods) {
          final description = goodsItem.description;
          final quantity = goodsItem.quantity.toDouble();
          final price = goodsItem.price.toDouble();

          if (!goodsData.containsKey(description)) {
            goodsData[description] = {'quantity': quantity, 'price': price};
          } else {
            var data = goodsData[description];
            data = {
              'quantity': (data?['quantity'] ?? 0.0) + quantity,
              'price': (data?['price'] ?? 0.0) + price,
            };
          }
        }
      }

      goodsData.forEach((description, data) {
        final startingQuantity = widget.inventories
                ?.where((inventory) => inventory.item == description)
                .map((inventory) => inventory.previousQuantity)
                .reduce(
                    (value, element) => value > element ? value : element) ??
            0;

        final remainingQuantity = startingQuantity - (data['quantity'] ?? 0);
        double price = data['price'] ?? 0.0;

        // Update totals
        totals['Quantity Sold'] =
            (totals['Quantity Sold'] ?? 0.0) + (data['quantity'] ?? 0.0);
        totals['Starting Quantity'] = (totals['Starting Quantity'] ?? 0.0) +
            (startingQuantity ?? 0.0).toDouble();
        totals['Remaining Quantity'] = (totals['Remaining Quantity'] ?? 0.0) +
            (remainingQuantity ?? 0.0).toDouble();
        totals['Total'] = (totals['Total'] ?? 0.0) + price;

        final List<String> entry = [
          description,
          NumberFormat.currency(
            symbol: 'Php ',
            decimalDigits: 2,
          ).format((data['quantity'] ?? 1) != 0
              ? price / (data['quantity'] ?? 1)
              : 0),
          safeToInt(data['quantity'])?.toString() ?? '0', // Use safeToInt here
          startingQuantity.toString(),
          remainingQuantity.toInt().toString(),
          NumberFormat.currency(
            symbol: 'Php ',
            decimalDigits: 2,
          ).format(price),
        ];

        entries.add(entry);
      });

      // Sort entries in ascending order of description
      entries.sort((a, b) => a[0].compareTo(b[0]));

      // Add totals to entries
      final List<String> totalRow = [
        'Total Sales',
        '',
        safeToInt(totals['Quantity Sold']).toString(), // Use safeToInt here
        safeToInt(totals['Starting Quantity'])?.toString() ??
            '0', // Use safeToInt here
        safeToInt(totals['Remaining Quantity'])?.toString() ??
            '0', // Use safeToInt here
        NumberFormat.currency(
          symbol: 'Php ',
          decimalDigits: 2,
        ).format(totals['Total']),
      ];

      entries.add(totalRow);

      return entries;
    }

    // Function to generate data for the Expenses table
    List<List<String>> generateExpensesTableData() {
      final List<List<String>> entries = [];
      double totalExpenses = 0.0; // Initialize totalExpenses

      // Filter transactions to get only those with type "expense"
      final expenseTransactions = widget.transactions
              ?.where((transaction) => transaction.type == 'expense')
              .toList() ??
          [];

      for (final transaction in expenseTransactions) {
        final description = generateExpenseDescription(transaction);

        final total = transaction.total.toDouble();
        final String formattedTotal = NumberFormat.currency(
          symbol: 'Php ',
          decimalDigits: 2,
        ).format(total);
        if (transaction.goods.isEmpty) {
          totalExpenses += total; // Accumulate totalExpenses
        }
        final List<String> entry = [
          description,
          !transaction.goods.isEmpty ? '($formattedTotal)' : formattedTotal,
        ];
        entries.add(entry);
      }
      // Add a row for the total expenses
      final List<String> totalRow = [
        'Total Expenses',
        NumberFormat.currency(
          symbol: 'Php ',
          decimalDigits: 2,
        ).format(totalExpenses),
      ];
      entries.add(totalRow);

      return entries;
    }

    // Function to create a table
    pw.Widget createRoomTable(List<List<String>> data,
        {double width = 0.0, bool last = false}) {
      if (data.isEmpty) {
        return pw.Text(widget.rooms.length
            .toString()); // Handle the case when data is empty
      }

      // List of headers
      List<String> headers = [
        "Room Number",
        "Room Price",
        "Amount Paid",
        "Stay Length",
      ];

      return pw.Container(
        width: width,
        child: pw.Table(
          border: pw.TableBorder.all(width: 1.0, color: PdfColors.black),
          children: [
            // Header row
            pw.TableRow(
              children: headers.asMap().entries.map((entry) {
                final int index = entry.key;
                final String header = entry.value;
                return pw.Container(
                  padding: pw.EdgeInsets.symmetric(
                    vertical: 1,
                    horizontal: 3,
                  ),
                  child: pw.Text(
                    header,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 8,
                    ),
                    textAlign:
                        index != 0 ? pw.TextAlign.center : pw.TextAlign.left,
                  ),
                );
              }).toList(),
            ),
            // Data rows
            for (int i = 0; i < data.length; i++)
              pw.TableRow(
                children: data[i].asMap().entries.map((entry) {
                  final int index = entry.key;
                  final String cell = entry.value;
                  return pw.Container(
                    padding: pw.EdgeInsets.symmetric(
                        vertical: 1, horizontal: 3), // Adjusted padding
                    child: pw.Text(
                      cell,
                      style: last && i == data.length - 1
                          ? pw.TextStyle(
                              fontSize: 8,
                              fontWeight:
                                  pw.FontWeight.bold) // Bold for the last row
                          : pw.TextStyle(fontSize: 8),
                      // Set textAlign to right for the last cell
                      textAlign: (index == 1 || index == 2)
                          ? pw.TextAlign.right
                          : (index != 0
                              ? pw.TextAlign.center
                              : pw.TextAlign.left),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      );
    }

    pw.Widget createGoodsTable(List<List<String>> data) {
      if (data.isEmpty) {
        return pw.Text(
            'There are no goods.'); // Handle the case when data is empty
      }
      // List of headers
      List<String> headers = [
        "Goods",
        "Price",
        "Quantity Sold",
        "Starting Quantity",
        "Remaining Quantity",
        "Total",
      ];

      return pw.Container(
        padding: pw.EdgeInsets.symmetric(horizontal: 34.0),
        child: pw.Table(
          border: pw.TableBorder.all(width: 1.0, color: PdfColors.black),
          children: [
            // Header row
            pw.TableRow(
              children: headers.asMap().entries.map((entry) {
                final int index = entry.key;
                final String header = entry.value;
                return pw.Container(
                  padding: pw.EdgeInsets.symmetric(
                    vertical: 1,
                    horizontal: 3,
                  ),
                  child: pw.Text(
                    header,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 8,
                    ),
                    textAlign:
                        index != 0 ? pw.TextAlign.center : pw.TextAlign.left,
                  ),
                );
              }).toList(),
            ),
            // Data rows
            for (int i = 0; i < data.length; i++)
              pw.TableRow(
                children: data[i].asMap().entries.map((entry) {
                  final int index = entry.key;
                  final String cell = entry.value;
                  return pw.Container(
                    padding: pw.EdgeInsets.symmetric(
                        vertical: 1, horizontal: 3), // Adjusted padding
                    child: pw.Text(
                      cell,
                      style: i == data.length - 1
                          ? pw.TextStyle(
                              fontSize: 8,
                              fontWeight:
                                  pw.FontWeight.bold) // Bold for the last row
                          : pw.TextStyle(fontSize: 8),
                      // Set textAlign to right for the last cell
                      textAlign: index == data[i].length - 1
                          ? pw.TextAlign.right
                          : (index != 0
                              ? pw.TextAlign.center
                              : pw.TextAlign.left),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      );
    }

    pw.Widget createExpensesTable(List<List<String>> data) {
      if (data.isEmpty) {
        return pw.Text(
            'There are no expenses.'); // Handle the case when data is empty
      }

      // List of headers
      List<String> expenseHeaders = ["Expenses", "Amount"];

      return pw.Container(
        padding: pw.EdgeInsets.symmetric(horizontal: 34.0),
        child: pw.Table(
          border: pw.TableBorder.all(width: 1.0, color: PdfColors.black),
          children: [
            // Header row
            pw.TableRow(
              children: expenseHeaders.asMap().entries.map((entry) {
                final int index = entry.key;
                final String header = entry.value;
                return pw.Container(
                  padding: pw.EdgeInsets.symmetric(
                    vertical: 1,
                    horizontal: 3,
                  ),
                  child: pw.Text(
                    header,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 8,
                    ),
                    textAlign:
                        index != 0 ? pw.TextAlign.center : pw.TextAlign.left,
                  ),
                );
              }).toList(),
            ),
            // Data rows
            for (int i = 0; i < data.length; i++)
              pw.TableRow(
                children: data[i].asMap().entries.map((entry) {
                  final int index = entry.key;
                  final String cell = entry.value;

                  return pw.Container(
                    padding: pw.EdgeInsets.symmetric(
                      vertical: 1,
                      horizontal: 3,
                    ),
                    child: pw.Text(
                      cell,
                      style: pw.TextStyle(
                        fontSize: 8,
                        fontWeight: i == data.length - 1
                            ? pw.FontWeight.bold
                            : pw.FontWeight.normal,
                      ),
                      // Set textAlign to right for the last cell
                      textAlign: index == data[i].length - 1
                          ? pw.TextAlign.right
                          : pw.TextAlign.left,
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      );
    }

    pw.Widget createBottomRow(RemittancesRecord remittance) {
      final changeTransactions = widget.transactions
              ?.where((transaction) => transaction.type == 'change')
              .toList() ??
          [];

      final total = NumberFormat.currency(
        symbol: 'Php ',
        decimalDigits: 2,
      ).format(remittance.net);

      final extraPhp = NumberFormat.currency(
        symbol: 'Php ',
        decimalDigits: 2,
      ).format(changeTransactions.isNotEmpty
          ? changeTransactions.first.total.abs()
          : 0);

      String capitalizeFirstLetter(String text) {
        if (text.isEmpty) {
          return text;
        }
        return text[0].toUpperCase() + text.substring(1);
      }

      return pw.Container(
        padding: pw.EdgeInsets.symmetric(horizontal: 34.0),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Prepared By: ${capitalizeFirstLetter(widget.preparedBy ?? '')}',
                  style: pw.TextStyle(fontSize: 12),
                ),
                pw.Text(
                  'Collected By: ${capitalizeFirstLetter(widget.collectedBy ?? '')}',
                  style: pw.TextStyle(fontSize: 12),
                ),
                // Add additional information if needed
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(
                  'Remittance Received: $total',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                // Add additional information if needed

                pw.Text(
                  "Extra amount received yesterday: $extraPhp",
                  style: pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    // Add a new page to the Document object
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.only(top: 34.0),
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              crossAxisAlignment:
                  pw.CrossAxisAlignment.start, // Align children to the right
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      padding:
                          pw.EdgeInsets.only(left: 34.0), // Padding to the left
                      child: pw.Text(
                        widget.remittance.hotel,
                        style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.SizedBox(height: 2),
                    pw.Container(
                      padding:
                          pw.EdgeInsets.only(left: 34.0), // Padding to the left
                      child: pw.Text(
                        "Remittance Report - $formattedDate",
                        style: pw.TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 15),
                pw.Container(
                  padding: pw.EdgeInsets.symmetric(
                    horizontal: 34.0,
                  ),
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      // First Table
                      createRoomTable(firstHalf,
                          width: (595.0 - 34.0 * 2 - 20) / 2),
                      pw.Spacer(), // Add a spacer to evenly distribute the space
                      // Second Table
                      createRoomTable(secondHalf,
                          width: (595.0 - 34.0 * 2 - 20) / 2, last: true),
                    ],
                  ),
                ),

                pw.SizedBox(height: 10),
                // Add the "Goods" table
                createGoodsTable(generateGoodsTableData()),
                pw.SizedBox(height: 10),
                createExpensesTable(generateExpensesTableData()),
                pw.SizedBox(height: 10),
                createBottomRow(widget.remittance),
              ],
            ),
          );
        },
      ),
    );

    await Printing.sharePdf(
        bytes: await pdf.save(),
        filename:
            "${widget.remittance.hotel} Remittance Report - $formattedDate.pdf");

    // You can save the PDF to a file, email it, or do other operations as needed
    // For simplicity, we are just printing the PDF as bytes
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await generatePdf(); // Call the PDF generation function
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            FlutterFlowTheme.of(context).primary, // Background color
        padding: EdgeInsets.all(16), // Add padding for spacing
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Set the border radius
        ),
      ),
      child: Text(
        'Share Remittance',
        style: TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
