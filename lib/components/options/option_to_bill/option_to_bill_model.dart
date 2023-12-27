import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/bill_edit/bill_edit_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'option_to_bill_widget.dart' show OptionToBillWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OptionToBillModel extends FlutterFlowModel<OptionToBillWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in changeDetails widget.
  BillsRecord? billToChange;
  // Stores action output result for [Backend Call - Read Document] action in replaceWidget widget.
  BillsRecord? bill;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
