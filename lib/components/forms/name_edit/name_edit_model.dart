import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'name_edit_widget.dart' show NameEditWidget;
import 'package:flutter/material.dart';

class NameEditModel extends FlutterFlowModel<NameEditWidget> {
  ///  Local state fields for this component.

  UsersRecord? user;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in NameEdit widget.
  UsersRecord? userToEdit;
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
