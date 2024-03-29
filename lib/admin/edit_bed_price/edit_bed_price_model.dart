import '/flutter_flow/flutter_flow_util.dart';
import 'edit_bed_price_widget.dart' show EditBedPriceWidget;
import 'package:flutter/material.dart';

class EditBedPriceModel extends FlutterFlowModel<EditBedPriceWidget> {
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
