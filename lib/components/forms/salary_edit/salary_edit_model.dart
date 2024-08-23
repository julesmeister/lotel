import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'salary_edit_widget.dart' show SalaryEditWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SalaryEditModel extends FlutterFlowModel<SalaryEditWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for salary widget.
  FocusNode? salaryFocusNode;
  TextEditingController? salaryTextController;
  String? Function(BuildContext, String?)? salaryTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    salaryFocusNode?.dispose();
    salaryTextController?.dispose();
  }
}
