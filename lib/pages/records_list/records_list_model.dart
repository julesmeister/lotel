import '/flutter_flow/flutter_flow_util.dart';
import 'records_list_widget.dart' show RecordsListWidget;
import 'package:flutter/material.dart';

class RecordsListModel extends FlutterFlowModel<RecordsListWidget> {
  ///  Local state fields for this page.

  String month = 'February';

  String year = '2024';

  bool showMonthPicker = true;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Bottom Sheet - ChangeDate] action in Column widget.
  DateTime? adjustedFixDateCopy;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
