import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'remittance_specific_transactions_widget.dart'
    show RemittanceSpecificTransactionsWidget;
import 'package:flutter/material.dart';

class RemittanceSpecificTransactionsModel
    extends FlutterFlowModel<RemittanceSpecificTransactionsWidget> {
  ///  Local state fields for this page.

  int loopTransactionsCounter = 0;

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

  int loopAbsencesCounter = 0;

  List<AbsencesRecord> absencesDocs = [];
  void addToAbsencesDocs(AbsencesRecord item) => absencesDocs.add(item);
  void removeFromAbsencesDocs(AbsencesRecord item) => absencesDocs.remove(item);
  void removeAtIndexFromAbsencesDocs(int index) => absencesDocs.removeAt(index);
  void insertAtIndexInAbsencesDocs(int index, AbsencesRecord item) =>
      absencesDocs.insert(index, item);
  void updateAbsencesDocsAtIndex(
          int index, Function(AbsencesRecord) updateFn) =>
      absencesDocs[index] = updateFn(absencesDocs[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - Read Document] action in remittanceSpecificTransactions widget.
  TransactionsRecord? transactionToList;
  // Stores action output result for [Backend Call - Read Document] action in remittanceSpecificTransactions widget.
  AbsencesRecord? absenceToList;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
