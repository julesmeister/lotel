import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/transaction_edit/transaction_edit_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'option_to_booking_transaction_widget.dart'
    show OptionToBookingTransactionWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
