import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'pendings_widget.dart' show PendingsWidget;
import 'package:flutter/material.dart';

class PendingsModel extends FlutterFlowModel<PendingsWidget> {
  ///  Local state fields for this page.

  List<RoomPendingStruct> selectedTransaction = [];
  void addToSelectedTransaction(RoomPendingStruct item) =>
      selectedTransaction.add(item);
  void removeFromSelectedTransaction(RoomPendingStruct item) =>
      selectedTransaction.remove(item);
  void removeAtIndexFromSelectedTransaction(int index) =>
      selectedTransaction.removeAt(index);
  void insertAtIndexInSelectedTransaction(int index, RoomPendingStruct item) =>
      selectedTransaction.insert(index, item);
  void updateSelectedTransactionAtIndex(
          int index, Function(RoomPendingStruct) updateFn) =>
      selectedTransaction[index] = updateFn(selectedTransaction[index]);

  int loopCounter = 0;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - Read Document] action in clearBalance widget.
  BookingsRecord? booking;
  // State field(s) for CheckboxListTile widget.

  Map<RoomPendingStruct, bool> checkboxListTileValueMap = {};
  List<RoomPendingStruct> get checkboxListTileCheckedItems =>
      checkboxListTileValueMap.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
