import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'extra_remittance_widget.dart' show ExtraRemittanceWidget;
import 'package:flutter/material.dart';

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
