import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'add_edit_location_widget.dart' show AddEditLocationWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
