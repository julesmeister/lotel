import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'staff_add_edit_widget.dart' show StaffAddEditWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StaffAddEditModel extends FlutterFlowModel<StaffAddEditWidget> {
  ///  Local state fields for this component.

  List<DocumentReference> caRefs = [];
  void addToCaRefs(DocumentReference item) => caRefs.add(item);
  void removeFromCaRefs(DocumentReference item) => caRefs.remove(item);
  void removeAtIndexFromCaRefs(int index) => caRefs.removeAt(index);
  void insertAtIndexInCaRefs(int index, DocumentReference item) =>
      caRefs.insert(index, item);
  void updateCaRefsAtIndex(int index, Function(DocumentReference) updateFn) =>
      caRefs[index] = updateFn(caRefs[index]);

  List<DocumentReference> absences = [];
  void addToAbsences(DocumentReference item) => absences.add(item);
  void removeFromAbsences(DocumentReference item) => absences.remove(item);
  void removeAtIndexFromAbsences(int index) => absences.removeAt(index);
  void insertAtIndexInAbsences(int index, DocumentReference item) =>
      absences.insert(index, item);
  void updateAbsencesAtIndex(int index, Function(DocumentReference) updateFn) =>
      absences[index] = updateFn(absences[index]);

  ///  State fields for stateful widgets in this component.

  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameController;
  String? Function(BuildContext, String?)? nameControllerValidator;
  // State field(s) for sss widget.
  FocusNode? sssFocusNode;
  TextEditingController? sssController;
  String? Function(BuildContext, String?)? sssControllerValidator;
  // State field(s) for rate widget.
  FocusNode? rateFocusNode;
  TextEditingController? rateController;
  String? Function(BuildContext, String?)? rateControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Row widget.
  StaffsRecord? createPayload;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    nameFocusNode?.dispose();
    nameController?.dispose();

    sssFocusNode?.dispose();
    sssController?.dispose();

    rateFocusNode?.dispose();
    rateController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
