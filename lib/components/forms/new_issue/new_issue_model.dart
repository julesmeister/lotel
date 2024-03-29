import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'new_issue_widget.dart' show NewIssueWidget;
import 'package:flutter/material.dart';

class NewIssueModel extends FlutterFlowModel<NewIssueWidget> {
  ///  Local state fields for this component.

  bool isLoading = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in NewIssue widget.
  IssuesRecord? issueToEdit;
  // State field(s) for detail widget.
  FocusNode? detailFocusNode;
  TextEditingController? detailController;
  String? Function(BuildContext, String?)? detailControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    detailFocusNode?.dispose();
    detailController?.dispose();
  }
}
