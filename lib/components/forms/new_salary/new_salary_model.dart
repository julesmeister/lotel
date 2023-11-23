import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'new_salary_widget.dart' show NewSalaryWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in NewSalary widget.
  List<StaffsRecord>? staff;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Firestore Query - Query a collection] action in DropDown widget.
  int? cashAdvances;
  // Stores action output result for [Firestore Query - Query a collection] action in DropDown widget.
  List<AdvancesRecord>? retrievedAdvances;
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
  // State field(s) for cab widget.
  FocusNode? cabFocusNode;
  TextEditingController? cabController;
  String? Function(BuildContext, String?)? cabControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Row widget.
  SalariesRecord? newSalary;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    rateFocusNode?.dispose();
    rateController?.dispose();

    sssFocusNode?.dispose();
    sssController?.dispose();

    caFocusNode?.dispose();
    caController?.dispose();

    cabFocusNode?.dispose();
    cabController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
