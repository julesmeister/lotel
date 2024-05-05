import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'history_in_inventory_widget.dart' show HistoryInInventoryWidget;
import 'package:flutter/material.dart';

class HistoryInInventoryModel
    extends FlutterFlowModel<HistoryInInventoryWidget> {
  ///  Local state fields for this page.

  DateTime? date;

  bool showDatePicker = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay;

  @override
  void initState(BuildContext context) {
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
  }

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
