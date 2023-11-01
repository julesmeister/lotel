import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/new_salary/new_salary_widget.dart';
import '/components/salary_options/salary_options_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'new_edit_payroll_widget.dart' show NewEditPayrollWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - Read Document] action in NewEditPayroll widget.
  PayrollsRecord? existingPayroll;
  // Stores action output result for [Firestore Query - Query a collection] action in NewEditPayroll widget.
  List<SalariesRecord>? existingSalaries;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  List<StaffsRecord>? staffsForSelection;
  // Stores action output result for [Bottom Sheet - NewSalary] action in IconButton widget.
  SalariesRecord? salary;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  StaffsRecord? staff;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<AdvancesRecord>? unsettledCashAdvance;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  PayrollsRecord? newPayroll;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
