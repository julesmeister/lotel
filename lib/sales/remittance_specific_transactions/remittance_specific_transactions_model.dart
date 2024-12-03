import '/backend/backend.dart';
import '/components/options/option_to_remove_book_remittance/option_to_remove_book_remittance_widget.dart';
import '/components/options/option_to_remove_expense_remittance/option_to_remove_expense_remittance_widget.dart';
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

  /// Action blocks.
  Future optionToBooking(
    BuildContext context, {
    TransactionsRecord? transaction,
    DocumentReference? remittance,
  }) async {
    if (FFAppState().role != 'demo') {
      var confirmDialogResponse = await showDialog<bool>(
            context: context,
            builder: (alertDialogContext) {
              return AlertDialog(
                title: const Text('Remove'),
                content: const Text(
                    'This will remove this booking from this remittance as well as adjust the values from its respective remittance.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext, false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext, true),
                    child: const Text('Confirm'),
                  ),
                ],
              );
            },
          ) ??
          false;
      if (confirmDialogResponse) {
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: OptionToRemoveBookRemittanceWidget(
                  remittance: remittance!,
                  transaction: transaction!,
                ),
              ),
            );
          },
        );
      }
    }
  }

  Future optionToExpense(
    BuildContext context, {
    required DocumentReference? remittance,
    required TransactionsRecord? transaction,
  }) async {
    if (FFAppState().role != 'demo') {
      var confirmDialogResponse = await showDialog<bool>(
            context: context,
            builder: (alertDialogContext) {
              return AlertDialog(
                title: const Text('Delete'),
                content: const Text(
                    'This will delete the transaction as well as adjust the values from the respective remittance.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext, false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext, true),
                    child: const Text('Confirm'),
                  ),
                ],
              );
            },
          ) ??
          false;
      if (confirmDialogResponse) {
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          enableDrag: false,
          useSafeArea: true,
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: OptionToRemoveExpenseRemittanceWidget(
                  remittance: remittance!,
                  transaction: transaction!,
                ),
              ),
            );
          },
        );
      }
    }
  }
}
