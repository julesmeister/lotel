import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/new_grocery/new_grocery_widget.dart';
import '/components/forms/new_issue/new_issue_widget.dart';
import '/components/forms/record_add_edit/record_add_edit_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'option_to_issue_widget.dart' show OptionToIssueWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
