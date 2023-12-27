import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/transaction_edit/transaction_edit_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'option_to_transaction_only_widget.dart'
    show OptionToTransactionOnlyWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OptionToTransactionOnlyModel
    extends FlutterFlowModel<OptionToTransactionOnlyWidget> {
  ///  Local state fields for this component.

  int loopInvetoryCounter = 0;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in changeDetails widget.
  TransactionsRecord? transactionToMark;
  // Stores action output result for [Firestore Query - Query a collection] action in changeDetails widget.
  int? countGrr;
  // Stores action output result for [Firestore Query - Query a collection] action in changeDetails widget.
  GoodsRevenueRatioRecord? lastGrr;
  // Stores action output result for [Backend Call - Read Document] action in delete widget.
  TransactionsRecord? transaction;
  // Stores action output result for [Backend Call - Read Document] action in delete widget.
  InventoriesRecord? inventory;
  // Stores action output result for [Firestore Query - Query a collection] action in delete widget.
  GoodsRecord? item;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
