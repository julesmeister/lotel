import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/transaction_edit/transaction_edit_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'option_to_booking_transaction_widget.dart'
    show OptionToBookingTransactionWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OptionToBookingTransactionModel
    extends FlutterFlowModel<OptionToBookingTransactionWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in OptionToBookingTransaction widget.
  RoomsRecord? room;
  // Stores action output result for [Backend Call - Read Document] action in replaceWidget widget.
  TransactionsRecord? trans;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
