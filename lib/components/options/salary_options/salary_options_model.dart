import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'salary_options_widget.dart' show SalaryOptionsWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SalaryOptionsModel extends FlutterFlowModel<SalaryOptionsWidget> {
  ///  Local state fields for this component.

  int loopCACounter = 0;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in delete widget.
  SalariesRecord? salaryToGetTotal;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
