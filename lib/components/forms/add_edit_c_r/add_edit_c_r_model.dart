import '/flutter_flow/flutter_flow_util.dart';
import 'add_edit_c_r_widget.dart' show AddEditCRWidget;
import 'package:flutter/material.dart';

class AddEditCRModel extends FlutterFlowModel<AddEditCRWidget> {
  ///  Local state fields for this component.

  String operator = '-';

  ///  State fields for stateful widgets in this component.

  // State field(s) for sockets widget.
  FocusNode? socketsFocusNode;
  TextEditingController? socketsTextController;
  String? Function(BuildContext, String?)? socketsTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    socketsFocusNode?.dispose();
    socketsTextController?.dispose();
  }
}
