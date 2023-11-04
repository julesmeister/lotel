import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/option_to_booking_transaction/option_to_booking_transaction_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/request_manager.dart';

import 'transactions_widget.dart' show TransactionsWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TransactionsModel extends FlutterFlowModel<TransactionsWidget> {
  ///  Local state fields for this page.

  DateTime? date;

  bool showDatePicker = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  /// Query cache managers for this widget.

  final _justGetNightsManager = StreamRequestManager<BookingsRecord>();
  Stream<BookingsRecord> justGetNights({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<BookingsRecord> Function() requestFn,
  }) =>
      _justGetNightsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearJustGetNightsCache() => _justGetNightsManager.clear();
  void clearJustGetNightsCacheKey(String? uniqueKey) =>
      _justGetNightsManager.clearRequest(uniqueKey);

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

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
  }

  void dispose() {
    unfocusNode.dispose();
    tabBarController?.dispose();

    /// Dispose query cache managers for this widget.

    clearJustGetNightsCache();

    clearTransactionsCache();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
