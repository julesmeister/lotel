import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'room_add_edit_widget.dart' show RoomAddEditWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RoomAddEditModel extends FlutterFlowModel<RoomAddEditWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for number widget.
  FocusNode? numberFocusNode;
  TextEditingController? numberTextController;
  String? Function(BuildContext, String?)? numberTextControllerValidator;
  // State field(s) for price widget.
  FocusNode? priceFocusNode;
  TextEditingController? priceTextController;
  String? Function(BuildContext, String?)? priceTextControllerValidator;
  // State field(s) for capacity widget.
  FocusNode? capacityFocusNode;
  TextEditingController? capacityTextController;
  String? Function(BuildContext, String?)? capacityTextControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Row widget.
  RoomsRecord? createRoom;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    numberFocusNode?.dispose();
    numberTextController?.dispose();

    priceFocusNode?.dispose();
    priceTextController?.dispose();

    capacityFocusNode?.dispose();
    capacityTextController?.dispose();
  }
}
