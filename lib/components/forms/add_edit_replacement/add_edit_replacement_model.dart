import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'add_edit_replacement_widget.dart' show AddEditReplacementWidget;
import 'package:flutter/material.dart';

class AddEditReplacementModel
    extends FlutterFlowModel<AddEditReplacementWidget> {
  ///  Local state fields for this component.

  String operator = '+';

  double bedPrice = 0.0;

  List<TransactionsRecord> transactions = [];
  void addToTransactions(TransactionsRecord item) => transactions.add(item);
  void removeFromTransactions(TransactionsRecord item) =>
      transactions.remove(item);
  void removeAtIndexFromTransactions(int index) => transactions.removeAt(index);
  void insertAtIndexInTransactions(int index, TransactionsRecord item) =>
      transactions.insert(index, item);
  void updateTransactionsAtIndex(
          int index, Function(TransactionsRecord) updateFn) =>
      transactions[index] = updateFn(transactions[index]);

  double lateCheckOutFee = 0.0;

  int loop = 0;

  double promoPercent = 0.0;

  double roomPrice = 0.0;

  int number = 0;

  ///  State fields for stateful widgets in this component.

  // State field(s) for number widget.
  FocusNode? numberFocusNode;
  TextEditingController? numberTextController;
  String? Function(BuildContext, String?)? numberTextControllerValidator;
  // State field(s) for watts widget.
  FocusNode? wattsFocusNode;
  TextEditingController? wattsTextController;
  String? Function(BuildContext, String?)? wattsTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    numberFocusNode?.dispose();
    numberTextController?.dispose();

    wattsFocusNode?.dispose();
    wattsTextController?.dispose();
  }
}
