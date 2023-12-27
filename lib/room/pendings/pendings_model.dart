import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import 'pendings_widget.dart' show PendingsWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class PendingsModel extends FlutterFlowModel<PendingsWidget> {
  ///  Local state fields for this page.

  List<TransactionsRecord> selectedTransaction = [];
  void addToSelectedTransaction(TransactionsRecord item) =>
      selectedTransaction.add(item);
  void removeFromSelectedTransaction(TransactionsRecord item) =>
      selectedTransaction.remove(item);
  void removeAtIndexFromSelectedTransaction(int index) =>
      selectedTransaction.removeAt(index);
  void insertAtIndexInSelectedTransaction(int index, TransactionsRecord item) =>
      selectedTransaction.insert(index, item);
  void updateSelectedTransactionAtIndex(
          int index, Function(TransactionsRecord) updateFn) =>
      selectedTransaction[index] = updateFn(selectedTransaction[index]);

  int loopCounter = 0;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - Read Document] action in clearBalance widget.
  BookingsRecord? booking;
  // State field(s) for roleList widget.

  PagingController<DocumentSnapshot?, TransactionsRecord>?
      roleListPagingController;
  Query? roleListPagingQuery;
  List<StreamSubscription?> roleListStreamSubscriptions = [];

  // State field(s) for CheckboxListTile widget.

  Map<TransactionsRecord, bool> checkboxListTileValueMap = {};
  List<TransactionsRecord> get checkboxListTileCheckedItems =>
      checkboxListTileValueMap.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    roleListStreamSubscriptions.forEach((s) => s?.cancel());
    roleListPagingController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.

  PagingController<DocumentSnapshot?, TransactionsRecord> setRoleListController(
    Query query, {
    DocumentReference<Object?>? parent,
  }) {
    roleListPagingController ??= _createRoleListController(query, parent);
    if (roleListPagingQuery != query) {
      roleListPagingQuery = query;
      roleListPagingController?.refresh();
    }
    return roleListPagingController!;
  }

  PagingController<DocumentSnapshot?, TransactionsRecord>
      _createRoleListController(
    Query query,
    DocumentReference<Object?>? parent,
  ) {
    final controller = PagingController<DocumentSnapshot?, TransactionsRecord>(
        firstPageKey: null);
    return controller
      ..addPageRequestListener(
        (nextPageMarker) => queryTransactionsRecordPage(
          queryBuilder: (_) => roleListPagingQuery ??= query,
          nextPageMarker: nextPageMarker,
          streamSubscriptions: roleListStreamSubscriptions,
          controller: controller,
          pageSize: 25,
          isStream: true,
        ),
      );
  }
}
