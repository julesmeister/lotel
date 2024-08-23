import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/change_date/change_date_widget.dart';
import '/components/options/cash_advance_options/cash_advance_options_widget.dart';
import '/components/options/salary_options/salary_options_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import '/flutter_flow/custom_functions.dart' as functions;
import 'individual_history_widget.dart' show IndividualHistoryWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class IndividualHistoryModel extends FlutterFlowModel<IndividualHistoryWidget> {
  ///  Local state fields for this page.

  String year = '2024';

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // State field(s) for ListView widget.

  PagingController<DocumentSnapshot?, SalariesRecord>?
      listViewPagingController1;
  Query? listViewPagingQuery1;

  // State field(s) for ListView widget.

  PagingController<DocumentSnapshot?, AdvancesRecord>?
      listViewPagingController2;
  Query? listViewPagingQuery2;

  // State field(s) for ListView widget.

  PagingController<DocumentSnapshot?, AbsencesRecord>?
      listViewPagingController3;
  Query? listViewPagingQuery3;

  // Stores action output result for [Bottom Sheet - ChangeDate] action in Column widget.
  DateTime? adjustedDate;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();

    listViewPagingController1?.dispose();

    listViewPagingController2?.dispose();

    listViewPagingController3?.dispose();
  }

  /// Additional helper methods.
  PagingController<DocumentSnapshot?, SalariesRecord> setListViewController1(
    Query query, {
    DocumentReference<Object?>? parent,
  }) {
    listViewPagingController1 ??= _createListViewController1(query, parent);
    if (listViewPagingQuery1 != query) {
      listViewPagingQuery1 = query;
      listViewPagingController1?.refresh();
    }
    return listViewPagingController1!;
  }

  PagingController<DocumentSnapshot?, SalariesRecord>
      _createListViewController1(
    Query query,
    DocumentReference<Object?>? parent,
  ) {
    final controller =
        PagingController<DocumentSnapshot?, SalariesRecord>(firstPageKey: null);
    return controller
      ..addPageRequestListener(
        (nextPageMarker) => querySalariesRecordPage(
          queryBuilder: (_) => listViewPagingQuery1 ??= query,
          nextPageMarker: nextPageMarker,
          controller: controller,
          pageSize: 25,
          isStream: false,
        ),
      );
  }

  PagingController<DocumentSnapshot?, AdvancesRecord> setListViewController2(
    Query query, {
    DocumentReference<Object?>? parent,
  }) {
    listViewPagingController2 ??= _createListViewController2(query, parent);
    if (listViewPagingQuery2 != query) {
      listViewPagingQuery2 = query;
      listViewPagingController2?.refresh();
    }
    return listViewPagingController2!;
  }

  PagingController<DocumentSnapshot?, AdvancesRecord>
      _createListViewController2(
    Query query,
    DocumentReference<Object?>? parent,
  ) {
    final controller =
        PagingController<DocumentSnapshot?, AdvancesRecord>(firstPageKey: null);
    return controller
      ..addPageRequestListener(
        (nextPageMarker) => queryAdvancesRecordPage(
          parent: parent,
          queryBuilder: (_) => listViewPagingQuery2 ??= query,
          nextPageMarker: nextPageMarker,
          controller: controller,
          pageSize: 25,
          isStream: false,
        ),
      );
  }

  PagingController<DocumentSnapshot?, AbsencesRecord> setListViewController3(
    Query query, {
    DocumentReference<Object?>? parent,
  }) {
    listViewPagingController3 ??= _createListViewController3(query, parent);
    if (listViewPagingQuery3 != query) {
      listViewPagingQuery3 = query;
      listViewPagingController3?.refresh();
    }
    return listViewPagingController3!;
  }

  PagingController<DocumentSnapshot?, AbsencesRecord>
      _createListViewController3(
    Query query,
    DocumentReference<Object?>? parent,
  ) {
    final controller =
        PagingController<DocumentSnapshot?, AbsencesRecord>(firstPageKey: null);
    return controller
      ..addPageRequestListener(
        (nextPageMarker) => queryAbsencesRecordPage(
          parent: parent,
          queryBuilder: (_) => listViewPagingQuery3 ??= query,
          nextPageMarker: nextPageMarker,
          controller: controller,
          pageSize: 25,
          isStream: false,
        ),
      );
  }
}
