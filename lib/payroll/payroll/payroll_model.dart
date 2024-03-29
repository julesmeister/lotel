import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'payroll_widget.dart' show PayrollWidget;
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PayrollModel extends FlutterFlowModel<PayrollWidget> {
  ///  Local state fields for this page.

  int? loopSalariesCounter = 0;

  int loopAdvancesCounter = 0;

  double cashAdvanceHolder = 0.0;

  List<AbsencesRecord> absences = [];
  void addToAbsences(AbsencesRecord item) => absences.add(item);
  void removeFromAbsences(AbsencesRecord item) => absences.remove(item);
  void removeAtIndexFromAbsences(int index) => absences.removeAt(index);
  void insertAtIndexInAbsences(int index, AbsencesRecord item) =>
      absences.insert(index, item);
  void updateAbsencesAtIndex(int index, Function(AbsencesRecord) updateFn) =>
      absences[index] = updateFn(absences[index]);

  bool isLoading = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for ListView widget.

  PagingController<DocumentSnapshot?, StaffsRecord>? listViewPagingController1;
  Query? listViewPagingQuery1;
  List<StreamSubscription?> listViewStreamSubscriptions1 = [];

  // State field(s) for ListView widget.

  PagingController<DocumentSnapshot?, PayrollsRecord>?
      listViewPagingController2;
  Query? listViewPagingQuery2;
  List<StreamSubscription?> listViewStreamSubscriptions2 = [];

  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  int? countPayrolls;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  PayrollsRecord? firstExistingPayroll;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  List<SalariesRecord>? sampleSalaries;
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  PayrollsRecord? newPayrollCreated;
  // Stores action output result for [Backend Call - Read Document] action in IconButton widget.
  StaffsRecord? staffToCheckFired;
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  SalariesRecord? newSalary;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  List<AdvancesRecord>? unSettledCashAdvances;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  List<AbsencesRecord>? absencesRaw;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    for (var s in listViewStreamSubscriptions1) {
      s?.cancel();
    }
    listViewPagingController1?.dispose();

    for (var s in listViewStreamSubscriptions2) {
      s?.cancel();
    }
    listViewPagingController2?.dispose();
  }

  /// Additional helper methods.
  PagingController<DocumentSnapshot?, StaffsRecord> setListViewController1(
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

  PagingController<DocumentSnapshot?, StaffsRecord> _createListViewController1(
    Query query,
    DocumentReference<Object?>? parent,
  ) {
    final controller =
        PagingController<DocumentSnapshot?, StaffsRecord>(firstPageKey: null);
    return controller
      ..addPageRequestListener(
        (nextPageMarker) => queryStaffsRecordPage(
          queryBuilder: (_) => listViewPagingQuery1 ??= query,
          nextPageMarker: nextPageMarker,
          streamSubscriptions: listViewStreamSubscriptions1,
          controller: controller,
          pageSize: 5,
          isStream: true,
        ),
      );
  }

  PagingController<DocumentSnapshot?, PayrollsRecord> setListViewController2(
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

  PagingController<DocumentSnapshot?, PayrollsRecord>
      _createListViewController2(
    Query query,
    DocumentReference<Object?>? parent,
  ) {
    final controller =
        PagingController<DocumentSnapshot?, PayrollsRecord>(firstPageKey: null);
    return controller
      ..addPageRequestListener(
        (nextPageMarker) => queryPayrollsRecordPage(
          queryBuilder: (_) => listViewPagingQuery2 ??= query,
          nextPageMarker: nextPageMarker,
          streamSubscriptions: listViewStreamSubscriptions2,
          controller: controller,
          pageSize: 6,
          isStream: true,
        ),
      );
  }
}
