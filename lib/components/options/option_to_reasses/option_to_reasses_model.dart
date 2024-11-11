import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'option_to_reasses_widget.dart' show OptionToReassesWidget;
import 'package:flutter/material.dart';

class OptionToReassesModel extends FlutterFlowModel<OptionToReassesWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in replaceWidget widget.
  TransactionsRecord? transaction;
  // Stores action output result for [Backend Call - Read Document] action in replaceWidget widget.
  BookingsRecord? booking;
  // Stores action output result for [Backend Call - Create Document] action in replaceWidget widget.
  HistoryRecord? history;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
