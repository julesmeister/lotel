import '/flutter_flow/flutter_flow_util.dart';
import 'add_edit_location_widget.dart' show AddEditLocationWidget;
import 'package:flutter/material.dart';

class AddEditLocationModel extends FlutterFlowModel<AddEditLocationWidget> {
  ///  Local state fields for this component.

  String operator = '-';

  ///  State fields for stateful widgets in this component.

  // State field(s) for location widget.
  FocusNode? locationFocusNode;
  TextEditingController? locationTextController;
  String? Function(BuildContext, String?)? locationTextControllerValidator;
  // State field(s) for sockets widget.
  FocusNode? socketsFocusNode;
  TextEditingController? socketsTextController;
  String? Function(BuildContext, String?)? socketsTextControllerValidator;
  // State field(s) for cr widget.
  bool? crValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    locationFocusNode?.dispose();
    locationTextController?.dispose();

    socketsFocusNode?.dispose();
    socketsTextController?.dispose();
  }
}
