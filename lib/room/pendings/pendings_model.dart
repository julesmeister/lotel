import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'pendings_widget.dart' show PendingsWidget;
import 'package:flutter/material.dart';

class PendingsModel extends FlutterFlowModel<PendingsWidget> {
  ///  Local state fields for this page.

  int loopCounter = 0;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - Read Document] action in clearBalance widget.
  BookingsRecord? booking;
  // Stores action output result for [Bottom Sheet - PayPendingPartially] action in clearBalance widget.
  bool? paidPartially;
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
