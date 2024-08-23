import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'extra_remittance_widget.dart' show ExtraRemittanceWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ExtraRemittanceModel extends FlutterFlowModel<ExtraRemittanceWidget> {
  ///  Local state fields for this component.

  TransactionsRecord? changeTransaction;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in ExtraRemittance widget.
  TransactionsRecord? change;
  // State field(s) for extra widget.
  FocusNode? extraFocusNode;
  TextEditingController? extraTextController;
  String? Function(BuildContext, String?)? extraTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    extraFocusNode?.dispose();
    extraTextController?.dispose();
  }
}
