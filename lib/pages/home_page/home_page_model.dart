import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/forms/change_date/change_date_widget.dart';
import '/components/forms/change_remittance/change_remittance_widget.dart';
import '/components/forms/new_grocery/new_grocery_widget.dart';
import '/components/forms/new_issue/new_issue_widget.dart';
import '/components/forms/promo/promo_widget.dart';
import '/components/options/collect_remittance_user/collect_remittance_user_widget.dart';
import '/components/options/option_to_issue/option_to_issue_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/request_manager.dart';

import 'home_page_widget.dart' show HomePageWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  int loopTransactionsCounter = 0;

  List<TransactionsRecord> transactionsToRemit = [];
  void addToTransactionsToRemit(TransactionsRecord item) =>
      transactionsToRemit.add(item);
  void removeFromTransactionsToRemit(TransactionsRecord item) =>
      transactionsToRemit.remove(item);
  void removeAtIndexFromTransactionsToRemit(int index) =>
      transactionsToRemit.removeAt(index);
  void insertAtIndexInTransactionsToRemit(int index, TransactionsRecord item) =>
      transactionsToRemit.insert(index, item);
  void updateTransactionsToRemitAtIndex(
          int index, Function(TransactionsRecord) updateFn) =>
      transactionsToRemit[index] = updateFn(transactionsToRemit[index]);

  int loopInventoryCounter = 0;

  List<DocumentReference> inventoriesToRemit = [];
  void addToInventoriesToRemit(DocumentReference item) =>
      inventoriesToRemit.add(item);
  void removeFromInventoriesToRemit(DocumentReference item) =>
      inventoriesToRemit.remove(item);
  void removeAtIndexFromInventoriesToRemit(int index) =>
      inventoriesToRemit.removeAt(index);
  void insertAtIndexInInventoriesToRemit(int index, DocumentReference item) =>
      inventoriesToRemit.insert(index, item);
  void updateInventoriesToRemitAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      inventoriesToRemit[index] = updateFn(inventoriesToRemit[index]);

  List<DocumentReference> bookingsToRemit = [];
  void addToBookingsToRemit(DocumentReference item) =>
      bookingsToRemit.add(item);
  void removeFromBookingsToRemit(DocumentReference item) =>
      bookingsToRemit.remove(item);
  void removeAtIndexFromBookingsToRemit(int index) =>
      bookingsToRemit.removeAt(index);
  void insertAtIndexInBookingsToRemit(int index, DocumentReference item) =>
      bookingsToRemit.insert(index, item);
  void updateBookingsToRemitAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      bookingsToRemit[index] = updateFn(bookingsToRemit[index]);

  List<DocumentReference> roomsToRemit = [];
  void addToRoomsToRemit(DocumentReference item) => roomsToRemit.add(item);
  void removeFromRoomsToRemit(DocumentReference item) =>
      roomsToRemit.remove(item);
  void removeAtIndexFromRoomsToRemit(int index) => roomsToRemit.removeAt(index);
  void insertAtIndexInRoomsToRemit(int index, DocumentReference item) =>
      roomsToRemit.insert(index, item);
  void updateRoomsToRemitAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      roomsToRemit[index] = updateFn(roomsToRemit[index]);

  bool showRemitController = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  List<HotelSettingsRecord>? homePagePreviousSnapshot;
  // Stores action output result for [Firestore Query - Query a collection] action in HomePage widget.
  LastLoginRecord? log;
  // Stores action output result for [Firestore Query - Query a collection] action in HomePage widget.
  HotelSettingsRecord? hotelSettingForLate;
  // Stores action output result for [Firestore Query - Query a collection] action in HomePage widget.
  HotelSettingsRecord? hotelSettingForLates;
  // Stores action output result for [Firestore Query - Query a collection] action in HomePage widget.
  HotelSettingsRecord? hotelSettingsHome;
  // Stores action output result for [Backend Call - Read Document] action in HomePage widget.
  HotelSettingsRecord? settings;
  // Stores action output result for [Backend Call - Read Document] action in HomePage widget.
  StatsRecord? alreadyStats;
  // Stores action output result for [Firestore Query - Query a collection] action in HomePage widget.
  List<StatsRecord>? fireStat;
  // Stores action output result for [Backend Call - Read Document] action in HomePage widget.
  HotelSettingsRecord? hotel;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  StatsRecord? serenityStat;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  StatsRecord? lifestyleStat;
  // State field(s) for allowRemittanceToBeSeen widget.
  bool? allowRemittanceToBeSeenValue;
  // Stores action output result for [Bottom Sheet - ChangeDate] action in Column widget.
  DateTime? adjustedLastRemit;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  RemittancesRecord? unRemitted;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  int? historyCount;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  int? countGroceries;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  int? countBills;

  /// Query cache managers for this widget.

  final _salesTotalManager = StreamRequestManager<List<TransactionsRecord>>();
  Stream<List<TransactionsRecord>> salesTotal({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<TransactionsRecord>> Function() requestFn,
  }) =>
      _salesTotalManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearSalesTotalCache() => _salesTotalManager.clear();
  void clearSalesTotalCacheKey(String? uniqueKey) =>
      _salesTotalManager.clearRequest(uniqueKey);

  final _totalTransactionsManager = FutureRequestManager<int>();
  Future<int> totalTransactions({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<int> Function() requestFn,
  }) =>
      _totalTransactionsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearTotalTransactionsCache() => _totalTransactionsManager.clear();
  void clearTotalTransactionsCacheKey(String? uniqueKey) =>
      _totalTransactionsManager.clearRequest(uniqueKey);

  final _issueHomeManager = StreamRequestManager<List<IssuesRecord>>();
  Stream<List<IssuesRecord>> issueHome({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<IssuesRecord>> Function() requestFn,
  }) =>
      _issueHomeManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearIssueHomeCache() => _issueHomeManager.clear();
  void clearIssueHomeCacheKey(String? uniqueKey) =>
      _issueHomeManager.clearRequest(uniqueKey);

  final _homeRemittanceManager =
      FutureRequestManager<List<RemittancesRecord>>();
  Future<List<RemittancesRecord>> homeRemittance({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<RemittancesRecord>> Function() requestFn,
  }) =>
      _homeRemittanceManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearHomeRemittanceCache() => _homeRemittanceManager.clear();
  void clearHomeRemittanceCacheKey(String? uniqueKey) =>
      _homeRemittanceManager.clearRequest(uniqueKey);

  final _hotelSettingsManager =
      StreamRequestManager<List<HotelSettingsRecord>>();
  Stream<List<HotelSettingsRecord>> hotelSettings({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<HotelSettingsRecord>> Function() requestFn,
  }) =>
      _hotelSettingsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearHotelSettingsCache() => _hotelSettingsManager.clear();
  void clearHotelSettingsCacheKey(String? uniqueKey) =>
      _hotelSettingsManager.clearRequest(uniqueKey);

  final _pendingCountsManager = FutureRequestManager<int>();
  Future<int> pendingCounts({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<int> Function() requestFn,
  }) =>
      _pendingCountsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearPendingCountsCache() => _pendingCountsManager.clear();
  void clearPendingCountsCacheKey(String? uniqueKey) =>
      _pendingCountsManager.clearRequest(uniqueKey);

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();

    /// Dispose query cache managers for this widget.

    clearSalesTotalCache();

    clearTotalTransactionsCache();

    clearIssueHomeCache();

    clearHomeRemittanceCache();

    clearHotelSettingsCache();

    clearPendingCountsCache();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
