import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_autocomplete_options_list.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'check_out_widget.dart' show CheckOutWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
  TextEditingController? priceController1;
  String? priceSelectedOption1;
  String? Function(BuildContext, String?)? priceController1Validator;
  // State field(s) for price widget.
  FocusNode? priceFocusNode2;
  TextEditingController? priceController2;
  String? Function(BuildContext, String?)? priceController2Validator;
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  TransactionsRecord? newTransaction;
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  InventoriesRecord? newInventory;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    priceFocusNode1?.dispose();

    priceFocusNode2?.dispose();
    priceController2?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
