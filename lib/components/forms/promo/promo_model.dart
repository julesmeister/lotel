import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'promo_widget.dart' show PromoWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PromoModel extends FlutterFlowModel<PromoWidget> {
  ///  Local state fields for this component.

  bool promoOn = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in Promo widget.
  HotelSettingsRecord? settings;
  // State field(s) for Switch widget.
  bool? switchValue;
  // State field(s) for detail widget.
  FocusNode? detailFocusNode;
  TextEditingController? detailTextController;
  String? Function(BuildContext, String?)? detailTextControllerValidator;
  // State field(s) for percent widget.
  FocusNode? percentFocusNode;
  TextEditingController? percentTextController;
  String? Function(BuildContext, String?)? percentTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    detailFocusNode?.dispose();
    detailTextController?.dispose();

    percentFocusNode?.dispose();
    percentTextController?.dispose();
  }
}
