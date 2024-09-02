import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'check_in_widget.dart' show CheckInWidget;
import 'package:flutter/material.dart';

class CheckInModel extends FlutterFlowModel<CheckInWidget> {
  ///  Local state fields for this page.

  bool paid = true;

  double price = 0.0;

  int? startingNights;

  String? startingBeds;

  List<DocumentReference> pendings = [];
  void addToPendings(DocumentReference item) => pendings.add(item);
  void removeFromPendings(DocumentReference item) => pendings.remove(item);
  void removeAtIndexFromPendings(int index) => pendings.removeAt(index);
  void insertAtIndexInPendings(int index, DocumentReference item) =>
      pendings.insert(index, item);
  void updatePendingsAtIndex(int index, Function(DocumentReference) updateFn) =>
      pendings[index] = updateFn(pendings[index]);

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

  String ability = 'normal';

  int loopPendingTransactions = 0;

  int loop = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Read Document] action in CheckIn widget.
  RoomsRecord? room;
  // Stores action output result for [Backend Call - Read Document] action in CheckIn widget.
  TransactionsRecord? trans;
  // Stores action output result for [Backend Call - Read Document] action in CheckIn widget.
  TransactionsRecord? pendingsToTrans;
  // State field(s) for nights widget.
  int? nightsValue;
  // State field(s) for ContactField widget.
  FocusNode? contactFieldFocusNode;
  TextEditingController? contactFieldTextController;
  String? Function(BuildContext, String?)? contactFieldTextControllerValidator;
  // State field(s) for DetailsField widget.
  FocusNode? detailsFieldFocusNode;
  TextEditingController? detailsFieldTextController;
  String? Function(BuildContext, String?)? detailsFieldTextControllerValidator;
  // State field(s) for beds widget.
  FormFieldController<List<String>>? bedsValueController;
  String? get bedsValue => bedsValueController?.value?.firstOrNull;
  set bedsValue(String? val) =>
      bedsValueController?.value = val != null ? [val] : [];
  // State field(s) for guests widget.
  FormFieldController<List<String>>? guestsValueController;
  String? get guestsValue => guestsValueController?.value?.firstOrNull;
  set guestsValue(String? val) =>
      guestsValueController?.value = val != null ? [val] : [];
  // State field(s) for hoursLateCheckout widget.
  FormFieldController<List<String>>? hoursLateCheckoutValueController;
  String? get hoursLateCheckoutValue =>
      hoursLateCheckoutValueController?.value?.firstOrNull;
  set hoursLateCheckoutValue(String? val) =>
      hoursLateCheckoutValueController?.value = val != null ? [val] : [];
  // Stores action output result for [Backend Call - Create Document] action in saveGuest widget.
  TransactionsRecord? refundTrans;
  // Stores action output result for [Backend Call - Create Document] action in saveGuest widget.
  TransactionsRecord? newExtPending;
  // Stores action output result for [Backend Call - Create Document] action in saveGuest widget.
  TransactionsRecord? newRefundPending;
  // Stores action output result for [Backend Call - Create Document] action in saveGuest widget.
  BookingsRecord? savedBooking;
  // Stores action output result for [Backend Call - Create Document] action in saveGuest widget.
  TransactionsRecord? checkin1;
  // Stores action output result for [Backend Call - Create Document] action in saveGuest widget.
  TransactionsRecord? newPending;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    contactFieldFocusNode?.dispose();
    contactFieldTextController?.dispose();

    detailsFieldFocusNode?.dispose();
    detailsFieldTextController?.dispose();
  }
}
