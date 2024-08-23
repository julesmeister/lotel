import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/forms/pay_pending_partially/pay_pending_partially_widget.dart';
import '/components/options/option_to_pending_transaction/option_to_pending_transaction_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import 'pendings_widget.dart' show PendingsWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PendingsModel extends FlutterFlowModel<PendingsWidget> {
  ///  Local state fields for this page.

  int loopCounter = 0;

  ///  State fields for stateful widgets in this page.

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
  void dispose() {}
}
