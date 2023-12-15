import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'new_issue_widget.dart' show NewIssueWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    detailFocusNode?.dispose();
    detailController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
