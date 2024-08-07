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

import 'package:month_picker_dialog/month_picker_dialog.dart';

class MonthPicker extends StatefulWidget {
  const MonthPicker({
    super.key,
    this.width,
    this.height,
    this.changeMonthYear,
    required this.initialMonth,
    required this.initialYear,
  });

  final double? width;
  final double? height;
  final Future Function(int month, int year)? changeMonthYear;
  final int initialMonth;
  final int initialYear;

  @override
  State<MonthPicker> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> {
  int _month = 1;
  int _year = 2024;
  @override
  void initState() {
    super.initState();
    // You can also fetch initial values from other sources here
    setState(() {
      _month = widget.initialMonth;
      _year = widget.initialYear;
    });
  }

  @override
  Widget build(BuildContext context) {
    return // Generated code for this Container Widget...
        // Generated code for this Container Widget...
        Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          // Handle click event here
          showMonthPicker(
            context: context,
            initialDate: DateTime(_year, _month),
          ).then((date) {
            if (date != null) {
              setState(() {
                _month = date.month;
                _year = date.year;
              });
              widget.changeMonthYear!(date.month, date.year);
            }
          });
        },
        child: Container(
          width: 234.0,
          height: 60.0,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0.0, 0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: Color(0xFF04B9F9),
                  size: 35.0,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select month and year',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF8A959A),
                            ),
                      ),
                      Text(
                        '${DateFormat('MMMM').format(DateTime(_year, _month, 1))} ${_year.toString()}',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF4B5257),
                              fontSize: 18.0,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
