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
import 'package:intl/intl.dart';

class PrintPayroll extends StatefulWidget {
  const PrintPayroll({
    Key? key,
    this.width,
    this.height,
    required this.salaries,
    required this.staffs,
    required this.date,
    required this.total,
    required this.fortnight,
    required this.hotel,
  }) : super(key: key);

  final double? width;
  final double? height;
  final List<SalariesRecord> salaries;
  final List<StaffsRecord> staffs;
  final DateTime date;
  final double total;
  final String fortnight;
  final String hotel;

  @override
  _PrintPayrollState createState() => _PrintPayrollState();
}

class _PrintPayrollState extends State<PrintPayroll> {
  Future<void> generatePdf() async {
    final pdf = pw.Document();
    // Header section
    final payrollReportTitle =
        '${widget.fortnight} ${widget.hotel} Payroll Report';
    final totalAmount = NumberFormat.currency(
      symbol: 'Php ', // Currency symbol
      decimalDigits: 2, // Number of decimal digits
    ).format(widget.total);

    // Salaries table
    final tableHeaders = ['Staff', 'Rate', 'SSS', 'Cash Advance', 'Salary'];
    final tableData = widget.salaries.map((salary) {
      final staffName = widget.staffs
          .firstWhere((staff) => staff.reference == salary.staff)
          .name;
      final formattedRate = NumberFormat.currency(
        symbol: 'Php ', // Currency symbol
        decimalDigits: 2, // Number of decimal digits
      ).format(salary.rate);
      // Format the salary with commas and a currency prefix
      final formattedSalary = NumberFormat.currency(
        symbol: 'Php ', // Currency symbol
        decimalDigits: 2, // Number of decimal digits
      ).format(salary.total);

      return [
        staffName,
        formattedRate,
        salary.sss.toStringAsFixed(2),
        salary.cashAdvance.toStringAsFixed(2),
        formattedSalary,
      ];
    }).toList();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.only(top: 10.0),
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text(
                payrollReportTitle,
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 20),
              // Salaries table
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
              pw.Text(
                'Total Amount: $totalAmount',
                style: pw.TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
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
          borderRadius: BorderRadius.circular(5.0), // Set the border radius
        ),
      ),
      child: Text(
        'Print Payroll',
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
