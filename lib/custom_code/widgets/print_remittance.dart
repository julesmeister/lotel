// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
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
  String formattedDate = '';

  @override
  void initState() {
    super.initState();
    formattedDate =
        DateFormat('EEEE MMMM d y h:mm a').format(widget.remittance.date!);
  }

  String generateExpenseDescription(TransactionsRecord transaction) {
    final goodsDescription = transaction.goods.isEmpty
        ? transaction.description
        : transaction.goods
            .map((goodsItem) =>
                '${goodsItem.description} x${goodsItem.quantity.toString()}')
            .join(', ');

    return goodsDescription;
  }

  Future<void> generatePdf() async {
    final pdf = pw.Document();

    List<List<String>> generateRoomTableData() {
      final List<List<String>> entries = [];

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

        final String total = bookTransactions.isNotEmpty
            ? "- ${bookTransactions.fold(0.0, (sum, transaction) => sum + transaction.total).toString()}"
            : '';

        final String totalText = bookTransactions.isNotEmpty
            ? '${room.price.toString()} $total'
            : room.vacant
                ? 'vacant'
                : 'still occupied';

        entry.add(totalText);
        Set<String> uniqueBookingReferences = Set<String>();
        entry.add(roomBookings.isNotEmpty
            ? roomBookings.fold(0, (sum, booking) {
                if (!uniqueBookingReferences.contains(booking.reference.path)) {
                  uniqueBookingReferences.add(booking.reference.path);
                  return sum + booking.nights;
                }
                return sum;
              }).toString()
            : '0');

        entries.add(entry);
      }

      return entries;
    }

    // Data for the table
    final roomTableData = [
      ['Room Number', 'Room Price', 'Nights of Stay'],
      ...generateRoomTableData(),
    ];

    // Split the data into two parts
    final int halfLength = (roomTableData.length / 2).ceil();
    final List<List<String>> firstHalf = roomTableData.sublist(0, halfLength);
    final List<List<String>> secondHalf = [
      roomTableData[0],
      ...roomTableData.sublist(halfLength),
    ];

    List<List<String>> generateGoodsTableData() {
      final List<List<String>> entries = [];
      final Map<String, Map<String, double>> goodsData = {};

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
            data ??= {'quantity': 0.0, 'price': 0.0}; // Initialize if null
            data['quantity'] = (data['quantity'] ?? 0.0) + quantity;
            data['price'] = (data['price'] ?? 0.0) + price;
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

        String formattedPrice = NumberFormat.currency(
          symbol: 'Php ',
          decimalDigits: 2,
        ).format(price);

        final List<String> entry = [
          description,
          (data['quantity'] ?? 0).toInt().toString(),
          startingQuantity.toString(),
          remainingQuantity.toInt().toString(),
          formattedPrice,
        ];

        entries.add(entry);
      });

      return entries;
    }

    // Function to generate data for the Expenses table
    List<List<String>> generateExpensesTableData() {
      final List<List<String>> entries = [];

      // Filter transactions to get only those with type "expense"
      final expenseTransactions = widget.transactions
              ?.where((transaction) => transaction.type == 'expense')
              .toList() ??
          [];

      for (final transaction in expenseTransactions) {
        final description = generateExpenseDescription(transaction);

        final total = transaction.total.toDouble();
        final List<String> entry = [
          description,
          NumberFormat.currency(
            symbol: 'Php ',
            decimalDigits: 2,
          ).format(total),
        ];
        entries.add(entry);
      }

      return entries;
    }

    // Function to create a table
    pw.Widget createRoomTable(List<List<String>> data) {
      if (data.isEmpty) {
        return pw.Text(widget.rooms.length
            .toString()); // Handle the case when data is empty
      }

      return pw.TableHelper.fromTextArray(
        headers: data[0],
        data: data.sublist(1),
        border: pw.TableBorder.all(width: 1.0, color: PdfColors.black),
        headerAlignment: pw.Alignment.centerLeft,
        // Define cell alignments for each column
        cellAlignment: pw.Alignment.centerLeft,
        headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8),
        cellStyle: pw.TextStyle(fontSize: 8),
        cellPadding: pw.EdgeInsets.symmetric(vertical: 1, horizontal: 3),
      );
    }

    pw.Widget createGoodsTable(List<List<String>> data) {
      if (data.isEmpty) {
        return pw.Text(
            'There are no goods.'); // Handle the case when data is empty
      }

      return pw.Container(
        padding: pw.EdgeInsets.symmetric(horizontal: 24.0),
        child: pw.TableHelper.fromTextArray(
          headers: [
            'Goods',
            'Quantity Sold',
            'Starting Quantity',
            'Remaining Quantity',
            'Total'
          ],
          data: data,
          border: pw.TableBorder.all(width: 1.0, color: PdfColors.black),
          headerAlignment: pw.Alignment.centerLeft,
          // Define cell alignments for each column
          cellAlignment: pw.Alignment.centerLeft,
          headerStyle:
              pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8),
          cellStyle: pw.TextStyle(fontSize: 8),
          cellPadding: pw.EdgeInsets.symmetric(vertical: 1, horizontal: 3),
        ),
      );
    }

    pw.Widget createExpensesTable(List<List<String>> data) {
      if (data.isEmpty) {
        return pw.Text(
            'There are no expenses.'); // Handle the case when data is empty
      }

      return pw.Container(
        padding: pw.EdgeInsets.symmetric(horizontal: 24.0),
        child: pw.TableHelper.fromTextArray(
          headers: <dynamic>['Expenses', 'Total'],
          data: data,
          border: pw.TableBorder.all(width: 1.0, color: PdfColors.black),
          headerAlignment: pw.Alignment.centerLeft,
          cellAlignment: pw.Alignment.centerLeft,
          headerStyle:
              pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8),
          cellStyle: pw.TextStyle(fontSize: 8),
          cellPadding: pw.EdgeInsets.symmetric(vertical: 1, horizontal: 3),
        ),
      );
    }

    pw.Widget createBottomRow(RemittancesRecord remittance) {
      final roomSales = NumberFormat.currency(
        symbol: 'Php ',
        decimalDigits: 2,
      ).format(
        // Calculate the sum of transactions.total for transaction.type == 'book'
        (widget.transactions ?? [])
            .where((transaction) => transaction.type == 'book')
            .fold(0.0, (sum, transaction) => sum + transaction.total),
      );

      final goodsSales = NumberFormat.currency(
        symbol: 'Php ',
        decimalDigits: 2,
      ).format(
        // Calculate the sum of transactions.total for transaction.type == 'goods'
        (widget.transactions ?? [])
            .where((transaction) => transaction.type == 'goods')
            .fold(0.0, (sum, transaction) => sum + transaction.total),
      );

      final expenses = NumberFormat.currency(
        symbol: 'Php ',
        decimalDigits: 2,
      ).format(remittance.expenses);

      final total = NumberFormat.currency(
        symbol: 'Php ',
        decimalDigits: 2,
      ).format(remittance.net);

      String capitalizeFirstLetter(String text) {
        if (text.isEmpty) {
          return text;
        }
        return text[0].toUpperCase() + text.substring(1);
      }

      return pw.Container(
        padding: pw.EdgeInsets.symmetric(horizontal: 24.0),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Sales',
                    style: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.bold)),
                pw.Text('Rooms: $roomSales', style: pw.TextStyle(fontSize: 12)),
                pw.Text('Goods: $goodsSales',
                    style: pw.TextStyle(fontSize: 12)),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Expenses: $expenses',
                    style: pw.TextStyle(fontSize: 12)),
                pw.Text('Net Total: $total', style: pw.TextStyle(fontSize: 12)),
                // Add additional information if needed
              ],
            ),
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
          ],
        ),
      );
    }

    // Add a new page to the Document object
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.only(top: 10.0),
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              children: [
                pw.Text(
                  widget.remittance.hotel,
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  "Remittance Report - $formattedDate",
                  style: pw.TextStyle(
                    fontSize: 14,
                  ),
                ),

                pw.SizedBox(height: 25),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    createRoomTable(firstHalf),
                    createRoomTable(secondHalf),
                  ],
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
