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
  String formattedDate = '';

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('EEEE MMMM d y h:mm a').format(widget.date);
  }

  String formatCurrency(double value) {
    return NumberFormat.currency(
      symbol: 'Php ',
      decimalDigits: 2,
    ).format(value);
  }

  Future<void> generatePdf() async {
    final pdf = pw.Document();
    // Header section
    final payrollReportTitle =
        '${widget.fortnight} ${widget.hotel} Payroll Report';
    final totalAmount = formatCurrency(widget.total);

    // Salaries table
    final tableHeaders = [
      'Staff',
      'Rate',
      'SSS',
      'Cash Advance',
      'Absences',
      'Salary'
    ];
    final tableData = widget.salaries.map((salary) {
      final staffName = widget.staffs
          .firstWhere((staff) => staff.reference == salary.staff)
          .name;

      final formattedRate = formatCurrency(salary.rate);
      final formattedSSS = formatCurrency(salary.sss);
      final formattedCashAdvance = formatCurrency(salary.cashAdvance);
      final formattedAbsences = formatCurrency(salary.absences);
      final formattedSalary = formatCurrency(salary.total);

      return [
        staffName,
        formattedRate,
        formattedSSS,
        formattedCashAdvance,
        formattedAbsences,
        formattedSalary,
      ];
    }).toList();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
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

    await Printing.sharePdf(
        bytes: await pdf.save(),
        filename:
            "${widget.hotel} ${widget.fortnight} Payroll - $formattedDate.pdf");
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
        'Share Payroll',
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
