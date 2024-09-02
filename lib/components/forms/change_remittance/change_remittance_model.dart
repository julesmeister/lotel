import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'change_remittance_widget.dart' show ChangeRemittanceWidget;
import 'package:flutter/material.dart';

class ChangeRemittanceModel extends FlutterFlowModel<ChangeRemittanceWidget> {
  ///  Local state fields for this component.

  int loopTransactionsCounter = 0;

  List<TransactionsRecord> transactionsToRemit = [];
  void addToTransactionsToRemit(TransactionsRecord item) =>
      transactionsToRemit.add(item);
  void removeFromTransactionsToRemit(TransactionsRecord item) =>
      transactionsToRemit.remove(item);
  void removeAtIndexFromTransactionsToRemit(int index) =>
      transactionsToRemit.removeAt(index);
  void insertAtIndexInTransactionsToRemit(int index, TransactionsRecord item) =>
      transactionsToRemit.insert(index, item);
  void updateTransactionsToRemitAtIndex(
          int index, Function(TransactionsRecord) updateFn) =>
      transactionsToRemit[index] = updateFn(transactionsToRemit[index]);

  int loopInventoryCounter = 0;

  List<DocumentReference> inventoriesToRemit = [];
  void addToInventoriesToRemit(DocumentReference item) =>
      inventoriesToRemit.add(item);
  void removeFromInventoriesToRemit(DocumentReference item) =>
      inventoriesToRemit.remove(item);
  void removeAtIndexFromInventoriesToRemit(int index) =>
      inventoriesToRemit.removeAt(index);
  void insertAtIndexInInventoriesToRemit(int index, DocumentReference item) =>
      inventoriesToRemit.insert(index, item);
  void updateInventoriesToRemitAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      inventoriesToRemit[index] = updateFn(inventoriesToRemit[index]);

  List<DocumentReference> bookingsToRemit = [];
  void addToBookingsToRemit(DocumentReference item) =>
      bookingsToRemit.add(item);
  void removeFromBookingsToRemit(DocumentReference item) =>
      bookingsToRemit.remove(item);
  void removeAtIndexFromBookingsToRemit(int index) =>
      bookingsToRemit.removeAt(index);
  void insertAtIndexInBookingsToRemit(int index, DocumentReference item) =>
      bookingsToRemit.insert(index, item);
  void updateBookingsToRemitAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      bookingsToRemit[index] = updateFn(bookingsToRemit[index]);

  List<RoomUsageStruct> roomUsage = [];
  void addToRoomUsage(RoomUsageStruct item) => roomUsage.add(item);
  void removeFromRoomUsage(RoomUsageStruct item) => roomUsage.remove(item);
  void removeAtIndexFromRoomUsage(int index) => roomUsage.removeAt(index);
  void insertAtIndexInRoomUsage(int index, RoomUsageStruct item) =>
      roomUsage.insert(index, item);
  void updateRoomUsageAtIndex(int index, Function(RoomUsageStruct) updateFn) =>
      roomUsage[index] = updateFn(roomUsage[index]);

  int loopFailedCounter = 0;

  List<DocumentReference> failedToRemitTransactions = [];
  void addToFailedToRemitTransactions(DocumentReference item) =>
      failedToRemitTransactions.add(item);
  void removeFromFailedToRemitTransactions(DocumentReference item) =>
      failedToRemitTransactions.remove(item);
  void removeAtIndexFromFailedToRemitTransactions(int index) =>
      failedToRemitTransactions.removeAt(index);
  void insertAtIndexInFailedToRemitTransactions(
          int index, DocumentReference item) =>
      failedToRemitTransactions.insert(index, item);
  void updateFailedToRemitTransactionsAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      failedToRemitTransactions[index] =
          updateFn(failedToRemitTransactions[index]);

  int loopAbsencesCounter = 0;

  List<AbsencesRecord> absencesToRemit = [];
  void addToAbsencesToRemit(AbsencesRecord item) => absencesToRemit.add(item);
  void removeFromAbsencesToRemit(AbsencesRecord item) =>
      absencesToRemit.remove(item);
  void removeAtIndexFromAbsencesToRemit(int index) =>
      absencesToRemit.removeAt(index);
  void insertAtIndexInAbsencesToRemit(int index, AbsencesRecord item) =>
      absencesToRemit.insert(index, item);
  void updateAbsencesToRemitAtIndex(
          int index, Function(AbsencesRecord) updateFn) =>
      absencesToRemit[index] = updateFn(absencesToRemit[index]);

  bool isLoading = false;

  List<DocumentReference> failedToRemitBookings = [];
  void addToFailedToRemitBookings(DocumentReference item) =>
      failedToRemitBookings.add(item);
  void removeFromFailedToRemitBookings(DocumentReference item) =>
      failedToRemitBookings.remove(item);
  void removeAtIndexFromFailedToRemitBookings(int index) =>
      failedToRemitBookings.removeAt(index);
  void insertAtIndexInFailedToRemitBookings(
          int index, DocumentReference item) =>
      failedToRemitBookings.insert(index, item);
  void updateFailedToRemitBookingsAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      failedToRemitBookings[index] = updateFn(failedToRemitBookings[index]);

  List<TransactionsRecord> allUnremittedTransactions = [];
  void addToAllUnremittedTransactions(TransactionsRecord item) =>
      allUnremittedTransactions.add(item);
  void removeFromAllUnremittedTransactions(TransactionsRecord item) =>
      allUnremittedTransactions.remove(item);
  void removeAtIndexFromAllUnremittedTransactions(int index) =>
      allUnremittedTransactions.removeAt(index);
  void insertAtIndexInAllUnremittedTransactions(
          int index, TransactionsRecord item) =>
      allUnremittedTransactions.insert(index, item);
  void updateAllUnremittedTransactionsAtIndex(
          int index, Function(TransactionsRecord) updateFn) =>
      allUnremittedTransactions[index] =
          updateFn(allUnremittedTransactions[index]);

  String happening = 'Neutral';

  double toRemitAmount = 0.0;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in ChangeRemittance widget.
  StatsRecord? initStat;
  // Stores action output result for [Firestore Query - Query a collection] action in ChangeRemittance widget.
  List<TransactionsRecord>? toRemit;
  // State field(s) for amount widget.
  FocusNode? amountFocusNode;
  TextEditingController? amountTextController;
  String? Function(BuildContext, String?)? amountTextControllerValidator;
  // State field(s) for changeExtra widget.
  FocusNode? changeExtraFocusNode;
  TextEditingController? changeExtraTextController;
  String? Function(BuildContext, String?)? changeExtraTextControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<TransactionsRecord>? transactions;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<InventoriesRecord>? inventoriesToRemitFirestore;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<AbsencesRecord>? unremittedAbsences;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  int? countGrr;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  GoodsRevenueRatioRecord? lastGrr;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  RemittancesRecord? newRemittanceCopyCopy;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    amountFocusNode?.dispose();
    amountTextController?.dispose();

    changeExtraFocusNode?.dispose();
    changeExtraTextController?.dispose();
  }
}
