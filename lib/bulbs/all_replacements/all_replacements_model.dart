import '/flutter_flow/flutter_flow_util.dart';
import 'all_replacements_widget.dart' show AllReplacementsWidget;
import 'package:flutter/material.dart';

class AllReplacementsModel extends FlutterFlowModel<AllReplacementsWidget> {
  ///  Local state fields for this page.

  String year = '2024';

  bool showMonthPicker = true;

  int loop = 0;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Bottom Sheet - ChangeDate] action in Column widget.
  DateTime? adjustedFixDateCopy;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
