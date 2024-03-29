import '/flutter_flow/flutter_flow_util.dart';
import 'new_option_widget.dart' show NewOptionWidget;
import 'package:flutter/material.dart';

class NewOptionModel extends FlutterFlowModel<NewOptionWidget> {
  ///  Local state fields for this component.

  String type = 'expense';

  ///  State fields for stateful widgets in this component.

  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameController;
  String? Function(BuildContext, String?)? nameControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameController?.dispose();
  }
}
