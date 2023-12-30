import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import 'pendings_widget.dart' show PendingsWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
