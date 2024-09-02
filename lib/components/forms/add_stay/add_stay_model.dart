import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'add_stay_widget.dart' show AddStayWidget;
import 'package:flutter/material.dart';

class AddStayModel extends FlutterFlowModel<AddStayWidget> {
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

  // Stores action output result for [Backend Call - Read Document] action in AddStay widget.
  HotelSettingsRecord? hotelSetting;
  // Stores action output result for [Backend Call - Read Document] action in AddStay widget.
  TransactionsRecord? bookingTrans;
  // Stores action output result for [Backend Call - Read Document] action in AddStay widget.
  RoomsRecord? room;
  // State field(s) for number widget.
  FocusNode? numberFocusNode;
  TextEditingController? numberTextController;
  String? Function(BuildContext, String?)? numberTextControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Row widget.
  TransactionsRecord? trans;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    numberFocusNode?.dispose();
    numberTextController?.dispose();
  }
}
