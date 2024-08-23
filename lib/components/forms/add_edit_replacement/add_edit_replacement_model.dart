import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'add_edit_replacement_widget.dart' show AddEditReplacementWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddEditReplacementModel
    extends FlutterFlowModel<AddEditReplacementWidget> {
  ///  Local state fields for this component.

  String operator = '+';

  int loop = 0;

  int number = 0;

  ///  State fields for stateful widgets in this component.

  // State field(s) for number widget.
  FocusNode? numberFocusNode;
  TextEditingController? numberTextController;
  String? Function(BuildContext, String?)? numberTextControllerValidator;
  // State field(s) for watts widget.
  FocusNode? wattsFocusNode;
  TextEditingController? wattsTextController;
  String? Function(BuildContext, String?)? wattsTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    numberFocusNode?.dispose();
    numberTextController?.dispose();

    wattsFocusNode?.dispose();
    wattsTextController?.dispose();
  }
}
