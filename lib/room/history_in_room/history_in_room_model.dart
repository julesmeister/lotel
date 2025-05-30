import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'history_in_room_widget.dart' show HistoryInRoomWidget;
import 'package:flutter/material.dart';

class HistoryInRoomModel extends FlutterFlowModel<HistoryInRoomWidget> {
  ///  Local state fields for this page.

  DateTime? date;

  bool showDatePicker = false;

  ///  State fields for stateful widgets in this page.

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
  void dispose() {}
}
