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

class ShareStats extends StatefulWidget {
  const ShareStats({
    Key? key,
    this.width,
    this.height,
    required this.stats,
  }) : super(key: key);

  final double? width;
  final double? height;
  final StatsRecord stats;

  @override
  _ShareStatsState createState() => _ShareStatsState();
}

class _ShareStatsState extends State<ShareStats> {
  Future<void> generatePdf() async {
    final pdf = pw.Document();

    final headerText =
        'Brief Summary of ${widget.stats.hotel} in ${widget.stats.month} ${widget.stats.year}';
    final headerSection = pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          headerText,
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    );

    String formatCurrency(double value) {
      return NumberFormat.currency(
        symbol: 'Php ',
        decimalDigits: 2,
      ).format(value);
    }

    double calculateNetFromExpenses() {
      // Calculate the net amount by subtracting expenses from income
      return widget.stats.goodsIncome - widget.stats.groceryExpenses;
    }

    // Table for stats
    final tableHeaders = ['Category', 'Amount'];
    final tableData = [
      ['Rooms Income', formatCurrency(widget.stats.roomsIncome)],
      ['Goods Income', formatCurrency(widget.stats.goodsIncome)],
      ['Expenses', formatCurrency(widget.stats.expenses)],
      ['Salaries', formatCurrency(widget.stats.salaries)],
      ['Groceries', formatCurrency(widget.stats.groceryExpenses)],
      ['Bills', formatCurrency(widget.stats.bills)],
      ['Net', formatCurrency(calculateNet())],
    ];

    // List of room usage
    final roomUsage = widget.stats.roomUsage;

    // Note on room usage
    final mostUsedRooms = getMostUsedRooms(roomUsage);
    final leastUsedRooms = getLeastUsedRooms(roomUsage);

    // Table for comparing Grocery Expenses and Goods Income
    final comparisonTableHeaders = ['Category', 'Amount'];
    final comparisonTableData = [
      ['Grocery Expenses', formatCurrency(widget.stats.groceryExpenses)],
      ['Goods Income', formatCurrency(widget.stats.goodsIncome)],
      ['Net', formatCurrency(calculateNetFromExpenses())],
    ];

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.SizedBox(height: 60),
              headerSection,
              pw.SizedBox(height: 20),
              // Stats table
              pw.Table.fromTextArray(
                headers: tableHeaders,
                data: tableData,
                cellAlignment: pw.Alignment.centerLeft,
                headerAlignment: pw.Alignment.centerLeft,
                cellStyle: pw.TextStyle(fontSize: 12),
                headerStyle:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12),
                cellPadding:
                    pw.EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              ),
              pw.SizedBox(height: 10),
              // Note on room usage
              pw.Text(
                'Most Used Rooms: ${mostUsedRooms.join(", ")}\nLeast Used Rooms: ${leastUsedRooms.join(", ")}',
                style: pw.TextStyle(
                  fontSize: 12,
                ),
              ),
              pw.SizedBox(height: 20),
              // Comparison table for Grocery Expenses and Goods Income
              pw.Table.fromTextArray(
                headers: comparisonTableHeaders,
                data: comparisonTableData,
                cellAlignment: pw.Alignment.centerLeft,
                headerAlignment: pw.Alignment.centerLeft,
                cellStyle: pw.TextStyle(fontSize: 12),
                headerStyle:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12),
                cellPadding:
                    pw.EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              ),
              pw.SizedBox(height: 10),
              // Note on whether Goods Income has surpassed Grocery Expenses
              pw.Text(
                'Note: ${goodsIncomeSurpassed() ? 'Goods Income has surpassed Grocery Expenses.' : 'Goods Income has not surpassed Grocery Expenses.'}',
                style: pw.TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          );
        },
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename:
          "${widget.stats.hotel}_${widget.stats.month}_${widget.stats.year}.pdf",
    );
  }

  bool goodsIncomeSurpassed() {
    return widget.stats.goodsIncome > widget.stats.groceryExpenses;
  }

  // New method to get most used rooms
  List<int> getMostUsedRooms(List<RoomUsageStruct> roomUsage) {
    roomUsage
        .sort((a, b) => b.use.compareTo(a.use)); // Sort in descending order
    return roomUsage.take(5).map((usage) => usage.number).toList();
  }

// New method to get least used rooms
  List<int> getLeastUsedRooms(List<RoomUsageStruct> roomUsage) {
    roomUsage.sort((a, b) => a.use.compareTo(b.use)); // Sort in ascending order
    return roomUsage.take(5).map((usage) => usage.number).toList();
  }

  double calculateNet() {
    // Calculate the net amount by subtracting expenses, salaries, grocery expenses, and bills from income
    return widget.stats.roomsIncome +
        widget.stats.goodsIncome -
        widget.stats.expenses -
        widget.stats.salaries -
        widget.stats.groceryExpenses -
        widget.stats.bills;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await generatePdf();
      },
      child: Icon(
        Icons.share_outlined,
        color: FlutterFlowTheme.of(context).secondaryText,
        size: 24,
      ),
    );
  }
}
