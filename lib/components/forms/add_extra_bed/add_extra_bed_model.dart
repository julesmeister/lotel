import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'add_extra_bed_widget.dart' show AddExtraBedWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddExtraBedModel extends FlutterFlowModel<AddExtraBedWidget> {
  ///  Local state fields for this component.

  String operator = '+';

  double bedPrice = 0.0;

  double promoPercent = 0.0;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in AddExtraBed widget.
  HotelSettingsRecord? hotelSetting;
  // State field(s) for number widget.
  FocusNode? numberFocusNode;
  TextEditingController? numberTextController;
  String? Function(BuildContext, String?)? numberTextControllerValidator;
  // Stores action output result for [Backend Call - Read Document] action in Row widget.
  RoomsRecord? room;
  // Stores action output result for [Backend Call - Create Document] action in Row widget.
  TransactionsRecord? trans;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    numberFocusNode?.dispose();
    numberTextController?.dispose();
  }
}
