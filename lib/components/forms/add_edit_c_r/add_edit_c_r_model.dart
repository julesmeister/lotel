import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'add_edit_c_r_widget.dart' show AddEditCRWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddEditCRModel extends FlutterFlowModel<AddEditCRWidget> {
  ///  Local state fields for this component.

  String operator = '-';

  ///  State fields for stateful widgets in this component.

  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  // State field(s) for sockets widget.
  FocusNode? socketsFocusNode;
  TextEditingController? socketsTextController;
  String? Function(BuildContext, String?)? socketsTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();

    socketsFocusNode?.dispose();
    socketsTextController?.dispose();
  }
}
