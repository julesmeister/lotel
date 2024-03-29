import '/flutter_flow/flutter_flow_util.dart';
import 'transaction_edit_widget.dart' show TransactionEditWidget;
import 'package:flutter/material.dart';

class TransactionEditModel extends FlutterFlowModel<TransactionEditWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for desc widget.
  FocusNode? descFocusNode;
  TextEditingController? descController;
  String? Function(BuildContext, String?)? descControllerValidator;
  // State field(s) for price widget.
  FocusNode? priceFocusNode;
  TextEditingController? priceController;
  String? Function(BuildContext, String?)? priceControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    descFocusNode?.dispose();
    descController?.dispose();

    priceFocusNode?.dispose();
    priceController?.dispose();
  }
}
