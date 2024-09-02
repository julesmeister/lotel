import '/flutter_flow/flutter_flow_util.dart';
import 'transaction_edit_widget.dart' show TransactionEditWidget;
import 'package:flutter/material.dart';

class TransactionEditModel extends FlutterFlowModel<TransactionEditWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for desc widget.
  FocusNode? descFocusNode;
  TextEditingController? descTextController;
  String? Function(BuildContext, String?)? descTextControllerValidator;
  // State field(s) for price widget.
  FocusNode? priceFocusNode;
  TextEditingController? priceTextController;
  String? Function(BuildContext, String?)? priceTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    descFocusNode?.dispose();
    descTextController?.dispose();

    priceFocusNode?.dispose();
    priceTextController?.dispose();
  }
}
