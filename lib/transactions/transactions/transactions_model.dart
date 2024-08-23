import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/change_date/change_date_widget.dart';
import '/components/options/option_to_booking_transaction/option_to_booking_transaction_widget.dart';
import '/components/options/option_to_transaction_only/option_to_transaction_only_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/request_manager.dart';

import 'transactions_widget.dart' show TransactionsWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class TransactionsModel extends FlutterFlowModel<TransactionsWidget> {
  ///  Local state fields for this page.

  DateTime? date;

  bool showDatePicker = false;

  int loopGoodsCounter = 0;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // State field(s) for ListView widget.

  PagingController<DocumentSnapshot?, AbsencesRecord>?
      listViewPagingController7;
  Query? listViewPagingQuery7;
  List<StreamSubscription?> listViewStreamSubscriptions7 = [];

  // Stores action output result for [Bottom Sheet - ChangeDate] action in listContainer widget.
  DateTime? adjustedDate;

  /// Query cache managers for this widget.

  final _transactionsManager = StreamRequestManager<List<TransactionsRecord>>();
  Stream<List<TransactionsRecord>> transactions({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<TransactionsRecord>> Function() requestFn,
  }) =>
      _transactionsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearTransactionsCache() => _transactionsManager.clear();
  void clearTransactionsCacheKey(String? uniqueKey) =>
      _transactionsManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    listViewStreamSubscriptions7.forEach((s) => s?.cancel());
    listViewPagingController7?.dispose();

    /// Dispose query cache managers for this widget.

    clearTransactionsCache();
  }

  /// Additional helper methods.
  PagingController<DocumentSnapshot?, AbsencesRecord> setListViewController7(
    Query query, {
    DocumentReference<Object?>? parent,
  }) {
    listViewPagingController7 ??= _createListViewController7(query, parent);
    if (listViewPagingQuery7 != query) {
      listViewPagingQuery7 = query;
      listViewPagingController7?.refresh();
    }
    return listViewPagingController7!;
  }

  PagingController<DocumentSnapshot?, AbsencesRecord>
      _createListViewController7(
    Query query,
    DocumentReference<Object?>? parent,
  ) {
    final controller =
        PagingController<DocumentSnapshot?, AbsencesRecord>(firstPageKey: null);
    return controller
      ..addPageRequestListener(
        (nextPageMarker) => queryAbsencesRecordPage(
          queryBuilder: (_) => listViewPagingQuery7 ??= query,
          nextPageMarker: nextPageMarker,
          streamSubscriptions: listViewStreamSubscriptions7,
          controller: controller,
          pageSize: 25,
          isStream: true,
        ),
      );
  }
}
