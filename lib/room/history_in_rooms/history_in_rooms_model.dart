import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'history_in_rooms_widget.dart' show HistoryInRoomsWidget;
import 'package:flutter/material.dart';

class HistoryInRoomsModel extends FlutterFlowModel<HistoryInRoomsWidget> {
  ///  Local state fields for this page.

  DateTime? date;

  bool showDatePicker = false;

  int loop = 0;

  List<HistoryRecord> histories = [];
  void addToHistories(HistoryRecord item) => histories.add(item);
  void removeFromHistories(HistoryRecord item) => histories.remove(item);
  void removeAtIndexFromHistories(int index) => histories.removeAt(index);
  void insertAtIndexInHistories(int index, HistoryRecord item) =>
      histories.insert(index, item);
  void updateHistoriesAtIndex(int index, Function(HistoryRecord) updateFn) =>
      histories[index] = updateFn(histories[index]);

  int loop2 = 0;

  bool loading = false;

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

  /// Action blocks.
  Future getHistoriesOfAllRooms(BuildContext context) async {
    List<HistoryRecord>? historiesOfRoom;

    // reset histories
    histories = [];
    loop = 0;
    loading = true;
    while (loop != widget.room?.length) {
      // histories
      historiesOfRoom = await queryHistoryRecordOnce(
        parent: widget.room?[loop].reference,
        queryBuilder: (historyRecord) => historyRecord
            .where(
              'date',
              isGreaterThanOrEqualTo: functions.startOfDay(date!),
            )
            .where(
              'date',
              isLessThanOrEqualTo: functions.endOfDay(date!),
            )
            .orderBy('date')
            .orderBy('description'),
      );
      // reset loop 2
      loop2 = 0;
      while (loop2 != historiesOfRoom.length) {
        // add history to list
        addToHistories(historiesOfRoom[loop2]);
        // + loop 2
        loop2 = loop2 + 1;
      }
      // + loop
      loop = loop + 1;
    }
    loading = false;
  }
}
