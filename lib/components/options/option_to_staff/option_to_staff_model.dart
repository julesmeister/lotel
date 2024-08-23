import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/staff_add_edit/staff_add_edit_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'option_to_staff_widget.dart' show OptionToStaffWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OptionToStaffModel extends FlutterFlowModel<OptionToStaffWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in replaceWidget widget.
  StaffsRecord? staff;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
