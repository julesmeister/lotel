import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/request_manager.dart';

import 'expense_widget.dart' show ExpenseWidget;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class ExpenseModel extends FlutterFlowModel<ExpenseWidget> {
  ///  Local state fields for this page.

  DocumentReference? staffSelected;

  DocumentReference? expenseRef;

  bool disableSubmit = true;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  TransactionsRecord? newCACopy;
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  TransactionsRecord? newExpCopy;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  int? countGrrCopy;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  GoodsRevenueRatioRecord? lastGrrCopy;
  // State field(s) for amount widget.
  FocusNode? amountFocusNode;
  TextEditingController? amountController;
  String? Function(BuildContext, String?)? amountControllerValidator;
  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionController;
  String? Function(BuildContext, String?)? descriptionControllerValidator;
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
    unfocusNode.dispose();
    amountFocusNode?.dispose();
    amountController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionController?.dispose();

    /// Dispose query cache managers for this widget.

    clearStaffsCashAdvanceCache();
  }
}
