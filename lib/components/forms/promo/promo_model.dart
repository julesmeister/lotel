import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'promo_widget.dart' show PromoWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
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
  TextEditingController? detailController;
  String? Function(BuildContext, String?)? detailControllerValidator;
  // State field(s) for percent widget.
  FocusNode? percentFocusNode;
  TextEditingController? percentController;
  String? Function(BuildContext, String?)? percentControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    detailFocusNode?.dispose();
    detailController?.dispose();

    percentFocusNode?.dispose();
    percentController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
