import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'check_out_widget.dart' show CheckOutWidget;
import 'package:flutter/material.dart';

class CheckOutModel extends FlutterFlowModel<CheckOutWidget> {
  ///  Local state fields for this page.

  int loopCounter = 0;

  int loopGoodsCounter = 0;

  bool expense = false;

  String whichExpense = 'consumedBy';

  bool isLoading = false;

  List<DocumentReference> inventories = [];
  void addToInventories(DocumentReference item) => inventories.add(item);
  void removeFromInventories(DocumentReference item) =>
      inventories.remove(item);
  void removeAtIndexFromInventories(int index) => inventories.removeAt(index);
  void insertAtIndexInInventories(int index, DocumentReference item) =>
      inventories.insert(index, item);
  void updateInventoriesAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      inventories[index] = updateFn(inventories[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue;
  // State field(s) for price widget.
  final priceKey1 = GlobalKey();
  FocusNode? priceFocusNode1;
  TextEditingController? priceTextController1;
  String? priceSelectedOption1;
  String? Function(BuildContext, String?)? priceTextController1Validator;
  // State field(s) for price widget.
  FocusNode? priceFocusNode2;
  TextEditingController? priceTextController2;
  String? Function(BuildContext, String?)? priceTextController2Validator;
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  TransactionsRecord? newTransaction;
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  InventoriesRecord? newInventory;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    priceFocusNode1?.dispose();

    priceFocusNode2?.dispose();
    priceTextController2?.dispose();
  }
}
