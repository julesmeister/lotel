import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'change_remittance_widget.dart' show ChangeRemittanceWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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

  int loopFailedTransactions = 0;

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

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in ChangeRemittance widget.
  StatsRecord? initStat;
  // State field(s) for changeExtra widget.
  FocusNode? changeExtraFocusNode;
  TextEditingController? changeExtraController;
  String? Function(BuildContext, String?)? changeExtraControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<TransactionsRecord>? transactions;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<InventoriesRecord>? inventoriesToRemitFirestore;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  BookingsRecord? booking;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<AbsencesRecord>? unremittedAbsences;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  RemittancesRecord? newRemittanceCopyCopy;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    changeExtraFocusNode?.dispose();
    changeExtraController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
