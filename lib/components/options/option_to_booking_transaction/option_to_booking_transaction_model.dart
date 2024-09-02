import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'option_to_booking_transaction_widget.dart'
    show OptionToBookingTransactionWidget;
import 'package:flutter/material.dart';

class OptionToBookingTransactionModel
    extends FlutterFlowModel<OptionToBookingTransactionWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in OptionToBookingTransaction widget.
  RoomsRecord? room;
  // Stores action output result for [Backend Call - Read Document] action in OptionToBookingTransaction widget.
  HotelSettingsRecord? settings;
  // Stores action output result for [Backend Call - Read Document] action in pending widget.
  BookingsRecord? bookingRef;
  // Stores action output result for [Backend Call - Read Document] action in replaceWidget widget.
  BookingsRecord? bookingNorm;
  // Stores action output result for [Backend Call - Read Document] action in replaceWidget widget.
  TransactionsRecord? readTransNorm;
  // Stores action output result for [Backend Call - Read Document] action in replaceWidget widget.
  BookingsRecord? booking;
  // Stores action output result for [Backend Call - Read Document] action in replaceWidget widget.
  TransactionsRecord? readTrans;
  // Stores action output result for [Backend Call - Read Document] action in replaceWidget widget.
  BookingsRecord? bookingPWD;
  // Stores action output result for [Backend Call - Read Document] action in replaceWidget widget.
  TransactionsRecord? readTransPWD;
  // Stores action output result for [Backend Call - Read Document] action in replaceWidget widget.
  TransactionsRecord? trans;
  // Stores action output result for [Backend Call - Read Document] action in replaceWidget widget.
  TransactionsRecord? duplicateTrans;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
