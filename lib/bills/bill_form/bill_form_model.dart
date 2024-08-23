import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/change_date/change_date_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:math';
import '/flutter_flow/custom_functions.dart' as functions;
import 'bill_form_widget.dart' show BillFormWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BillFormModel extends FlutterFlowModel<BillFormWidget> {
  ///  Local state fields for this page.

  DocumentReference? staffSelected;

  DocumentReference? expenseRef;

  bool disableSubmit = true;

  DateTime? date;

  DocumentReference? stats;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  List<OptionsRecord>? choices;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  StatsRecord? statsBillBelong;
  // Stores action output result for [Bottom Sheet - ChangeDate] action in Row widget.
  DateTime? adjustedDate;
  // State field(s) for amount widget.
  FocusNode? amountFocusNode;
  TextEditingController? amountTextController;
  String? Function(BuildContext, String?)? amountTextControllerValidator;
  // State field(s) for afterdue widget.
  FocusNode? afterdueFocusNode;
  TextEditingController? afterdueTextController;
  String? Function(BuildContext, String?)? afterdueTextControllerValidator;
  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  // State field(s) for choices widget.
  FormFieldController<List<String>>? choicesValueController;
  String? get choicesValue => choicesValueController?.value?.firstOrNull;
  set choicesValue(String? val) =>
      choicesValueController?.value = val != null ? [val] : [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    amountFocusNode?.dispose();
    amountTextController?.dispose();

    afterdueFocusNode?.dispose();
    afterdueTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();
  }
}
