import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'change_amount_widget.dart' show ChangeAmountWidget;
import 'package:flutter/material.dart';

class ChangeAmountModel extends FlutterFlowModel<ChangeAmountWidget> {
  ///  Local state fields for this component.

  TransactionsRecord? changeTransaction;

  ///  State fields for stateful widgets in this component.

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
