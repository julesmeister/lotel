import '/flutter_flow/flutter_flow_util.dart';
import 'late_checkout_fee_widget.dart' show LateCheckoutFeeWidget;
import 'package:flutter/material.dart';

class LateCheckoutFeeModel extends FlutterFlowModel<LateCheckoutFeeWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
