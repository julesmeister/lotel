import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'bill_edit_widget.dart' show BillEditWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BillEditModel extends FlutterFlowModel<BillEditWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in Row widget.
  StatsRecord? rightStats;
  // Stores action output result for [Firestore Query - Query a collection] action in Row widget.
  List<OptionsRecord>? choices;
  // State field(s) for desc widget.
  FocusNode? descFocusNode;
  TextEditingController? descTextController;
  String? Function(BuildContext, String?)? descTextControllerValidator;
  // State field(s) for amount widget.
  FocusNode? amountFocusNode;
  TextEditingController? amountTextController;
  String? Function(BuildContext, String?)? amountTextControllerValidator;
  // State field(s) for afterdue widget.
  FocusNode? afterdueFocusNode;
  TextEditingController? afterdueTextController;
  String? Function(BuildContext, String?)? afterdueTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    descFocusNode?.dispose();
    descTextController?.dispose();

    amountFocusNode?.dispose();
    amountTextController?.dispose();

    afterdueFocusNode?.dispose();
    afterdueTextController?.dispose();
  }
}
