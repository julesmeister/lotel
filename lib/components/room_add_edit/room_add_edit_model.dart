import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
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
  TextEditingController? numberController;
  String? Function(BuildContext, String?)? numberControllerValidator;
  // State field(s) for price widget.
  FocusNode? priceFocusNode;
  TextEditingController? priceController;
  String? Function(BuildContext, String?)? priceControllerValidator;
  // State field(s) for capacity widget.
  FocusNode? capacityFocusNode;
  TextEditingController? capacityController;
  String? Function(BuildContext, String?)? capacityControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Row widget.
  RoomsRecord? createRoom;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    numberFocusNode?.dispose();
    numberController?.dispose();

    priceFocusNode?.dispose();
    priceController?.dispose();

    capacityFocusNode?.dispose();
    capacityController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
