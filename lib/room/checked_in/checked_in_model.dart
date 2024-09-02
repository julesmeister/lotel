import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/request_manager.dart';

import 'checked_in_widget.dart' show CheckedInWidget;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class CheckedInModel extends FlutterFlowModel<CheckedInWidget> {
  ///  Local state fields for this page.

  bool showChangePrice = false;

  bool showMoveRoom = false;

  List<DocumentReference> pendings = [];
  void addToPendings(DocumentReference item) => pendings.add(item);
  void removeFromPendings(DocumentReference item) => pendings.remove(item);
  void removeAtIndexFromPendings(int index) => pendings.removeAt(index);
  void insertAtIndexInPendings(int index, DocumentReference item) =>
      pendings.insert(index, item);
  void updatePendingsAtIndex(int index, Function(DocumentReference) updateFn) =>
      pendings[index] = updateFn(pendings[index]);

  int loopPendingCounter = 0;

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

  String operator = '-';

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // Stores action output result for [Firestore Query - Query a collection] action in ChoiceChips widget.
  TransactionsRecord? transaction;
  // Stores action output result for [Bottom Sheet - OptionToBooking] action in Button widget.
  bool? toChangePrice;
  // State field(s) for priceChangedescription widget.
  String? priceChangedescriptionValue;
  FormFieldController<String>? priceChangedescriptionValueController;
  // State field(s) for adjust widget.
  FocusNode? adjustFocusNode;
  TextEditingController? adjustTextController;
  String? Function(BuildContext, String?)? adjustTextControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in saveChangedPrice widget.
  HotelSettingsRecord? hotelSetting;
  // Stores action output result for [Backend Call - Create Document] action in saveChangedPrice widget.
  TransactionsRecord? changePriceTrans;
  // Stores action output result for [Backend Call - Create Document] action in saveChangedPrice widget.
  TransactionsRecord? newPending;

  /// Query cache managers for this widget.

  final _bookingDetailsManager = StreamRequestManager<BookingsRecord>();
  Stream<BookingsRecord> bookingDetails({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<BookingsRecord> Function() requestFn,
  }) =>
      _bookingDetailsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearBookingDetailsCache() => _bookingDetailsManager.clear();
  void clearBookingDetailsCacheKey(String? uniqueKey) =>
      _bookingDetailsManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    adjustFocusNode?.dispose();
    adjustTextController?.dispose();

    /// Dispose query cache managers for this widget.

    clearBookingDetailsCache();
  }
}
