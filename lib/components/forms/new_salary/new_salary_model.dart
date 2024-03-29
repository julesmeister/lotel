import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'new_salary_widget.dart' show NewSalaryWidget;
import 'package:flutter/material.dart';

class NewSalaryModel extends FlutterFlowModel<NewSalaryWidget> {
  ///  Local state fields for this component.

  StaffsRecord? selectedStaff;

  bool edit = false;

  int loopAdvancesCounter = 0;

  double cashAdvanceTotal = 0.0;

  List<AdvancesRecord> cashAdvancesList = [];
  void addToCashAdvancesList(AdvancesRecord item) => cashAdvancesList.add(item);
  void removeFromCashAdvancesList(AdvancesRecord item) =>
      cashAdvancesList.remove(item);
  void removeAtIndexFromCashAdvancesList(int index) =>
      cashAdvancesList.removeAt(index);
  void insertAtIndexInCashAdvancesList(int index, AdvancesRecord item) =>
      cashAdvancesList.insert(index, item);
  void updateCashAdvancesListAtIndex(
          int index, Function(AdvancesRecord) updateFn) =>
      cashAdvancesList[index] = updateFn(cashAdvancesList[index]);

  List<AbsencesRecord> absencesList = [];
  void addToAbsencesList(AbsencesRecord item) => absencesList.add(item);
  void removeFromAbsencesList(AbsencesRecord item) => absencesList.remove(item);
  void removeAtIndexFromAbsencesList(int index) => absencesList.removeAt(index);
  void insertAtIndexInAbsencesList(int index, AbsencesRecord item) =>
      absencesList.insert(index, item);
  void updateAbsencesListAtIndex(
          int index, Function(AbsencesRecord) updateFn) =>
      absencesList[index] = updateFn(absencesList[index]);

  int loopAbsencesCounter = 0;

  double absencesTotal = 0.0;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in NewSalary widget.
  List<AbsencesRecord>? occuringAbsences;
  // Stores action output result for [Firestore Query - Query a collection] action in NewSalary widget.
  List<StaffsRecord>? staffs;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Firestore Query - Query a collection] action in DropDown widget.
  List<AdvancesRecord>? cashAdvances;
  // Stores action output result for [Firestore Query - Query a collection] action in DropDown widget.
  List<AbsencesRecord>? absences;
  // State field(s) for rate widget.
  FocusNode? rateFocusNode;
  TextEditingController? rateController;
  String? Function(BuildContext, String?)? rateControllerValidator;
  // State field(s) for sss widget.
  FocusNode? sssFocusNode;
  TextEditingController? sssController;
  String? Function(BuildContext, String?)? sssControllerValidator;
  // State field(s) for ca widget.
  FocusNode? caFocusNode;
  TextEditingController? caController;
  String? Function(BuildContext, String?)? caControllerValidator;
  // State field(s) for absences widget.
  FocusNode? absencesFocusNode;
  TextEditingController? absencesController;
  String? Function(BuildContext, String?)? absencesControllerValidator;
  // Stores action output result for [Backend Call - Read Document] action in Row widget.
  SalariesRecord? updatedSalary;
  // Stores action output result for [Backend Call - Create Document] action in Row widget.
  SalariesRecord? newSalary;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    rateFocusNode?.dispose();
    rateController?.dispose();

    sssFocusNode?.dispose();
    sssController?.dispose();

    caFocusNode?.dispose();
    caController?.dispose();

    absencesFocusNode?.dispose();
    absencesController?.dispose();
  }
}
