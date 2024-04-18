import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'staff_add_edit_widget.dart' show StaffAddEditWidget;
import 'package:flutter/material.dart';

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
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  // State field(s) for sss widget.
  FocusNode? sssFocusNode;
  TextEditingController? sssTextController;
  String? Function(BuildContext, String?)? sssTextControllerValidator;
  // State field(s) for rate widget.
  FocusNode? rateFocusNode;
  TextEditingController? rateTextController;
  String? Function(BuildContext, String?)? rateTextControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Row widget.
  StaffsRecord? createPayload;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    sssFocusNode?.dispose();
    sssTextController?.dispose();

    rateFocusNode?.dispose();
    rateTextController?.dispose();
  }
}
