import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'new_space_widget.dart' show NewSpaceWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NewSpaceModel extends FlutterFlowModel<NewSpaceWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for unit widget.
  FocusNode? unitFocusNode;
  TextEditingController? unitController;
  String? Function(BuildContext, String?)? unitControllerValidator;
  // State field(s) for owner widget.
  FocusNode? ownerFocusNode;
  TextEditingController? ownerController;
  String? Function(BuildContext, String?)? ownerControllerValidator;
  // State field(s) for amount widget.
  FocusNode? amountFocusNode;
  TextEditingController? amountController;
  String? Function(BuildContext, String?)? amountControllerValidator;
  // State field(s) for amountCollected widget.
  FocusNode? amountCollectedFocusNode;
  TextEditingController? amountCollectedController;
  String? Function(BuildContext, String?)? amountCollectedControllerValidator;
  // State field(s) for collected widget.
  bool? collectedValue;
  // Stores action output result for [Backend Call - Read Document] action in Row widget.
  SpacesRecord? updatedSpace;
  // Stores action output result for [Backend Call - Create Document] action in Row widget.
  SpacesRecord? newSpace;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unitFocusNode?.dispose();
    unitController?.dispose();

    ownerFocusNode?.dispose();
    ownerController?.dispose();

    amountFocusNode?.dispose();
    amountController?.dispose();

    amountCollectedFocusNode?.dispose();
    amountCollectedController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
