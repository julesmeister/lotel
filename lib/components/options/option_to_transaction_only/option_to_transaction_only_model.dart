import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'option_to_transaction_only_widget.dart'
    show OptionToTransactionOnlyWidget;
import 'package:flutter/material.dart';

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

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
