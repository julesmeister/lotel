import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:math';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/request_manager.dart';

import 'expense_widget.dart' show ExpenseWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ExpenseModel extends FlutterFlowModel<ExpenseWidget> {
  ///  Local state fields for this page.

  DocumentReference? staffSelected;

  DocumentReference? expenseRef;

  bool disableSubmit = true;

  int loop = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  TransactionsRecord? newCACopy;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  int? duplicatewithin1hour;
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  TransactionsRecord? newExpCopy;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  int? countGrrCopy;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  GoodsRevenueRatioRecord? lastGrrCopy;
  // State field(s) for amount widget.
  FocusNode? amountFocusNode;
  TextEditingController? amountTextController;
  String? Function(BuildContext, String?)? amountTextControllerValidator;
  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  // State field(s) for choices widget.
  FormFieldController<List<String>>? choicesValueController;
  String? get choicesValue => choicesValueController?.value?.firstOrNull;
  set choicesValue(String? val) =>
      choicesValueController?.value = val != null ? [val] : [];
  // State field(s) for selectedName widget.
  String? selectedNameValue;
  FormFieldController<String>? selectedNameValueController;

  /// Query cache managers for this widget.

  final _staffsCashAdvanceManager = StreamRequestManager<List<StaffsRecord>>();
  Stream<List<StaffsRecord>> staffsCashAdvance({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<StaffsRecord>> Function() requestFn,
  }) =>
      _staffsCashAdvanceManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearStaffsCashAdvanceCache() => _staffsCashAdvanceManager.clear();
  void clearStaffsCashAdvanceCacheKey(String? uniqueKey) =>
      _staffsCashAdvanceManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    amountFocusNode?.dispose();
    amountTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();

    /// Dispose query cache managers for this widget.

    clearStaffsCashAdvanceCache();
  }
}
