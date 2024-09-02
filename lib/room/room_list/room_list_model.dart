import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'room_list_widget.dart' show RoomListWidget;
import 'package:flutter/material.dart';

class RoomListModel extends FlutterFlowModel<RoomListWidget> {
  ///  Local state fields for this page.

  List<DocumentReference> selectedRooms = [];
  void addToSelectedRooms(DocumentReference item) => selectedRooms.add(item);
  void removeFromSelectedRooms(DocumentReference item) =>
      selectedRooms.remove(item);
  void removeAtIndexFromSelectedRooms(int index) =>
      selectedRooms.removeAt(index);
  void insertAtIndexInSelectedRooms(int index, DocumentReference item) =>
      selectedRooms.insert(index, item);
  void updateSelectedRoomsAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      selectedRooms[index] = updateFn(selectedRooms[index]);

  int loopCounter = 0;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for CheckboxListTile widget.
  Map<RoomsRecord, bool> checkboxListTileValueMap1 = {};
  List<RoomsRecord> get checkboxListTileCheckedItems1 =>
      checkboxListTileValueMap1.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  // State field(s) for CheckboxListTile widget.
  Map<RoomsRecord, bool> checkboxListTileValueMap2 = {};
  List<RoomsRecord> get checkboxListTileCheckedItems2 =>
      checkboxListTileValueMap2.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
