import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'new_edit_payroll_widget.dart' show NewEditPayrollWidget;
import 'package:flutter/material.dart';

class NewEditPayrollModel extends FlutterFlowModel<NewEditPayrollWidget> {
  ///  Local state fields for this page.

  DateTime? date;

  String fortnight = '1st';

  bool edit = false;

  bool settled = false;

  List<SalariesRecord> salaries = [];
  void addToSalaries(SalariesRecord item) => salaries.add(item);
  void removeFromSalaries(SalariesRecord item) => salaries.remove(item);
  void removeAtIndexFromSalaries(int index) => salaries.removeAt(index);
  void insertAtIndexInSalaries(int index, SalariesRecord item) =>
      salaries.insert(index, item);
  void updateSalariesAtIndex(int index, Function(SalariesRecord) updateFn) =>
      salaries[index] = updateFn(salaries[index]);

  DocumentReference? ref;

  bool approved = false;

  int loopAdvancesCounter = 0;

  int loopSalariesCounter = 0;

  List<SalariesRecord> salariesToDelete = [];
  void addToSalariesToDelete(SalariesRecord item) => salariesToDelete.add(item);
  void removeFromSalariesToDelete(SalariesRecord item) =>
      salariesToDelete.remove(item);
  void removeAtIndexFromSalariesToDelete(int index) =>
      salariesToDelete.removeAt(index);
  void insertAtIndexInSalariesToDelete(int index, SalariesRecord item) =>
      salariesToDelete.insert(index, item);
  void updateSalariesToDeleteAtIndex(
          int index, Function(SalariesRecord) updateFn) =>
      salariesToDelete[index] = updateFn(salariesToDelete[index]);

  int loopCACounterUnsettle = 0;

  List<StaffsRecord> staffs = [];
  void addToStaffs(StaffsRecord item) => staffs.add(item);
  void removeFromStaffs(StaffsRecord item) => staffs.remove(item);
  void removeAtIndexFromStaffs(int index) => staffs.removeAt(index);
  void insertAtIndexInStaffs(int index, StaffsRecord item) =>
      staffs.insert(index, item);
  void updateStaffsAtIndex(int index, Function(StaffsRecord) updateFn) =>
      staffs[index] = updateFn(staffs[index]);

  bool showChangeRate = false;

  SalariesRecord? tempSalary;

  int loopAbsencesCounter = 0;

  List<AbsencesRecord> absencesToSettle = [];
  void addToAbsencesToSettle(AbsencesRecord item) => absencesToSettle.add(item);
  void removeFromAbsencesToSettle(AbsencesRecord item) =>
      absencesToSettle.remove(item);
  void removeAtIndexFromAbsencesToSettle(int index) =>
      absencesToSettle.removeAt(index);
  void insertAtIndexInAbsencesToSettle(int index, AbsencesRecord item) =>
      absencesToSettle.insert(index, item);
  void updateAbsencesToSettleAtIndex(
          int index, Function(AbsencesRecord) updateFn) =>
      absencesToSettle[index] = updateFn(absencesToSettle[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Read Document] action in NewEditPayroll widget.
  PayrollsRecord? existingPayroll;
  // Stores action output result for [Firestore Query - Query a collection] action in NewEditPayroll widget.
  List<SalariesRecord>? existingSalaries;
  // Stores action output result for [Firestore Query - Query a collection] action in NewEditPayroll widget.
  List<StaffsRecord>? staffsOfThisHotel;
  // Stores action output result for [Bottom Sheet - AddEditSalary] action in IconButton widget.
  SalariesRecord? salary;
  // Stores action output result for [Bottom Sheet - ChangeDate] action in Text widget.
  DateTime? adjustedDate;
  // Stores action output result for [Firestore Query - Query a collection] action in Text widget.
  StatsRecord? prevStats;
  // Stores action output result for [Firestore Query - Query a collection] action in Text widget.
  StatsRecord? nowStats;
  // State field(s) for newRate widget.
  FocusNode? newRateFocusNode;
  TextEditingController? newRateTextController;
  String? Function(BuildContext, String?)? newRateTextControllerValidator;
  // State field(s) for newSSS widget.
  FocusNode? newSSSFocusNode;
  TextEditingController? newSSSTextController;
  String? Function(BuildContext, String?)? newSSSTextControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  List<SalariesRecord>? updatedSalaries;
  // Stores action output result for [Bottom Sheet - AddEditSalary] action in listContainer widget.
  SalariesRecord? updatedSalary;
  // Stores action output result for [Firestore Query - Query a collection] action in save widget.
  StatsRecord? appropriateStats;
  // Stores action output result for [Backend Call - Read Document] action in save widget.
  StaffsRecord? staff;
  // Stores action output result for [Firestore Query - Query a collection] action in save widget.
  List<AdvancesRecord>? unsettledCashAdvance;
  // Stores action output result for [Firestore Query - Query a collection] action in save widget.
  List<AbsencesRecord>? absences;
  // Stores action output result for [Backend Call - Create Document] action in save widget.
  PayrollsRecord? newPayroll;
  // Stores action output result for [Firestore Query - Query a collection] action in clearCAs widget.
  int? countUnsettled;
  // Stores action output result for [Backend Call - Read Document] action in clearCAs widget.
  StaffsRecord? staffClear;
  // Stores action output result for [Firestore Query - Query a collection] action in clearCAs widget.
  List<AdvancesRecord>? unsettledCashAdvanceClear;
  // Stores action output result for [Firestore Query - Query a collection] action in clearCAs widget.
  List<AbsencesRecord>? absencesClear;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    newRateFocusNode?.dispose();
    newRateTextController?.dispose();

    newSSSFocusNode?.dispose();
    newSSSTextController?.dispose();
  }
}
