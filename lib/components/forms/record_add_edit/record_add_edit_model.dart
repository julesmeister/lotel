import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_autocomplete_options_list.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'record_add_edit_widget.dart' show RecordAddEditWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RecordAddEditModel extends FlutterFlowModel<RecordAddEditWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for details widget.
  FocusNode? detailsFocusNode1;
  TextEditingController? detailsTextController1;
  String? Function(BuildContext, String?)? detailsTextController1Validator;
  // State field(s) for details widget.
  final detailsKey2 = GlobalKey();
  FocusNode? detailsFocusNode2;
  TextEditingController? detailsTextController2;
  String? detailsSelectedOption2;
  String? Function(BuildContext, String?)? detailsTextController2Validator;
  // State field(s) for details widget.
  final detailsKey3 = GlobalKey();
  FocusNode? detailsFocusNode3;
  TextEditingController? detailsTextController3;
  String? detailsSelectedOption3;
  String? Function(BuildContext, String?)? detailsTextController3Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    detailsFocusNode1?.dispose();
    detailsTextController1?.dispose();

    detailsFocusNode2?.dispose();

    detailsFocusNode3?.dispose();
  }
}
