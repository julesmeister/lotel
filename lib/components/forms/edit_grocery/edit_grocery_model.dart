import '/flutter_flow/flutter_flow_util.dart';
import 'edit_grocery_widget.dart' show EditGroceryWidget;
import 'package:flutter/material.dart';

class EditGroceryModel extends FlutterFlowModel<EditGroceryWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for remark widget.
  FocusNode? remarkFocusNode;
  TextEditingController? remarkTextController;
  String? Function(BuildContext, String?)? remarkTextControllerValidator;
  // State field(s) for amount widget.
  FocusNode? amountFocusNode;
  TextEditingController? amountTextController;
  String? Function(BuildContext, String?)? amountTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    remarkFocusNode?.dispose();
    remarkTextController?.dispose();

    amountFocusNode?.dispose();
    amountTextController?.dispose();
  }
}
