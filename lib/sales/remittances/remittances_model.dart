import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'remittances_widget.dart' show RemittancesWidget;
import 'package:flutter/material.dart';

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

  int loop = 0;

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

  @override
  void initState(BuildContext context) {
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
  }

  @override
  void dispose() {}
}
