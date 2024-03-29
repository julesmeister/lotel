import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'replenish_widget.dart' show ReplenishWidget;
import 'package:flutter/material.dart';

class ReplenishModel extends FlutterFlowModel<ReplenishWidget> {
  ///  Local state fields for this page.

  int loopCounter = 0;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in Replenish widget.
  int? replenishNeeded;
  // State field(s) for CheckboxListTile widget.

  Map<GoodsRecord, bool> checkboxListTileValueMap1 = {};
  List<GoodsRecord> get checkboxListTileCheckedItems1 =>
      checkboxListTileValueMap1.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  // State field(s) for CheckboxListTile widget.

  Map<GoodsRecord, bool> checkboxListTileValueMap2 = {};
  List<GoodsRecord> get checkboxListTileCheckedItems2 =>
      checkboxListTileValueMap2.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  // State field(s) for CheckboxListTile widget.

  Map<GoodsRecord, bool> checkboxListTileValueMap3 = {};
  List<GoodsRecord> get checkboxListTileCheckedItems3 =>
      checkboxListTileValueMap3.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  // State field(s) for CheckboxListTile widget.

  Map<GoodsRecord, bool> checkboxListTileValueMap4 = {};
  List<GoodsRecord> get checkboxListTileCheckedItems4 =>
      checkboxListTileValueMap4.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  // State field(s) for CheckboxListTile widget.

  Map<GoodsRecord, bool> checkboxListTileValueMap5 = {};
  List<GoodsRecord> get checkboxListTileCheckedItems5 =>
      checkboxListTileValueMap5.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  List<GoodsRecord>? replenished;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
