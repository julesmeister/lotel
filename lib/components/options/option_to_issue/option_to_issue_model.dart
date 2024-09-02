import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'option_to_issue_widget.dart' show OptionToIssueWidget;
import 'package:flutter/material.dart';

class OptionToIssueModel extends FlutterFlowModel<OptionToIssueWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in replaceWidget widget.
  RemittancesRecord? latestRemittance;
  // Stores action output result for [Backend Call - Read Document] action in replaceWidget widget.
  IssuesRecord? issueToRecord;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
