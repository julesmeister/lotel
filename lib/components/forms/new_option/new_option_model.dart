import '/flutter_flow/flutter_flow_util.dart';
import 'new_option_widget.dart' show NewOptionWidget;
import 'package:flutter/material.dart';

class NewOptionModel extends FlutterFlowModel<NewOptionWidget> {
  ///  Local state fields for this component.

  String type = 'expense';

  ///  State fields for stateful widgets in this component.

  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();
  }
}
