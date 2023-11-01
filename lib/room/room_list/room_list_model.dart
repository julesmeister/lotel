import '/backend/backend.dart';
import '/components/room_add_edit/room_add_edit_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'room_list_widget.dart' show RoomListWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
