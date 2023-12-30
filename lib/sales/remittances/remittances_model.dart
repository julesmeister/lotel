import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/options/prepared_remittance_user/prepared_remittance_user_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'remittances_widget.dart' show RemittancesWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class RemittancesModel extends FlutterFlowModel<RemittancesWidget> {
  ///  Local state fields for this page.

  DateTime? date;

  bool showDatePicker = false;

  List<InventoriesRecord> inventories = [];
  void addToInventories(InventoriesRecord item) => inventories.add(item);
  void removeFromInventories(InventoriesRecord item) =>
      inventories.remove(item);
  void removeAtIndexFromInventories(int index) => inventories.removeAt(index);
  void insertAtIndexInInventories(int index, InventoriesRecord item) =>
      inventories.insert(index, item);
  void updateInventoriesAtIndex(
          int index, Function(InventoriesRecord) updateFn) =>
      inventories[index] = updateFn(inventories[index]);

  List<BookingsRecord> bookings = [];
  void addToBookings(BookingsRecord item) => bookings.add(item);
  void removeFromBookings(BookingsRecord item) => bookings.remove(item);
  void removeAtIndexFromBookings(int index) => bookings.removeAt(index);
  void insertAtIndexInBookings(int index, BookingsRecord item) =>
      bookings.insert(index, item);
  void updateBookingsAtIndex(int index, Function(BookingsRecord) updateFn) =>
      bookings[index] = updateFn(bookings[index]);

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

  bool showLoadButton = true;

  bool showDownloadButton = false;

  int loopInvetoryCounter = 0;

  int loopBookCounter = 0;

  int loopTransactionCounter = 0;

  List<RoomsRecord> rooms = [];
  void addToRooms(RoomsRecord item) => rooms.add(item);
  void removeFromRooms(RoomsRecord item) => rooms.remove(item);
  void removeAtIndexFromRooms(int index) => rooms.removeAt(index);
  void insertAtIndexInRooms(int index, RoomsRecord item) =>
      rooms.insert(index, item);
  void updateRoomsAtIndex(int index, Function(RoomsRecord) updateFn) =>
      rooms[index] = updateFn(rooms[index]);

  int loopAbsencesCounter = 0;

  List<AbsencesRecord> absences = [];
  void addToAbsences(AbsencesRecord item) => absences.add(item);
  void removeFromAbsences(AbsencesRecord item) => absences.remove(item);
  void removeAtIndexFromAbsences(int index) => absences.removeAt(index);
  void insertAtIndexInAbsences(int index, AbsencesRecord item) =>
      absences.insert(index, item);
  void updateAbsencesAtIndex(int index, Function(AbsencesRecord) updateFn) =>
      absences[index] = updateFn(absences[index]);

  bool isLoading = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in remittances widget.
  RemittancesRecord? latestRemittance;
  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<RoomsRecord>? roomInThisHotel;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  InventoriesRecord? inventoryToList;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  BookingsRecord? bookToList;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  TransactionsRecord? transactionToList;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  AbsencesRecord? absenceToList;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  UsersRecord? preparedBy;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  UsersRecord? collectedBy;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
  }

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
