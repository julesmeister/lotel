import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'purge_widget.dart' show PurgeWidget;
import 'package:flutter/material.dart';

class PurgeModel extends FlutterFlowModel<PurgeWidget> {
  ///  Local state fields for this page.

  bool showCalendar = false;

  DateRange? marker = DateRange.Start;

  DateTime? startDate;

  DateTime? endDate;

  int recordsCount = 0;

  int loop = 0;

  bool isLoading = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay;
  // Stores action output result for [Firestore Query - Query a collection] action in Calendar widget.
  int? bookingsCount;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<BookingsRecord>? bookings;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  int? recount;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  PurgedRecord? purged;

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
