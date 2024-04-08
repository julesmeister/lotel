import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'bills_list_widget.dart' show BillsListWidget;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BillsListModel extends FlutterFlowModel<BillsListWidget> {
  ///  Local state fields for this page.

  List<String> allDescriptions = [];
  void addToAllDescriptions(String item) => allDescriptions.add(item);
  void removeFromAllDescriptions(String item) => allDescriptions.remove(item);
  void removeAtIndexFromAllDescriptions(int index) =>
      allDescriptions.removeAt(index);
  void insertAtIndexInAllDescriptions(int index, String item) =>
      allDescriptions.insert(index, item);
  void updateAllDescriptionsAtIndex(int index, Function(String) updateFn) =>
      allDescriptions[index] = updateFn(allDescriptions[index]);

  List<String> showInList = [];
  void addToShowInList(String item) => showInList.add(item);
  void removeFromShowInList(String item) => showInList.remove(item);
  void removeAtIndexFromShowInList(int index) => showInList.removeAt(index);
  void insertAtIndexInShowInList(int index, String item) =>
      showInList.insert(index, item);
  void updateShowInListAtIndex(int index, Function(String) updateFn) =>
      showInList[index] = updateFn(showInList[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in billsList widget.
  List<BillsRecord>? allBills;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // State field(s) for ListView widget.

  PagingController<DocumentSnapshot?, BillsRecord>? listViewPagingController;
  Query? listViewPagingQuery;
  List<StreamSubscription?> listViewStreamSubscriptions = [];

  // Stores action output result for [Bottom Sheet - ChangeDate] action in Column widget.
  DateTime? adjustedDate;
  // Stores action output result for [Firestore Query - Query a collection] action in Column widget.
  StatsRecord? prevStats;
  // Stores action output result for [Firestore Query - Query a collection] action in Column widget.
  StatsRecord? belongingStats;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    for (var s in listViewStreamSubscriptions) {
      s?.cancel();
    }
    listViewPagingController?.dispose();
  }

  /// Additional helper methods.
  PagingController<DocumentSnapshot?, BillsRecord> setListViewController(
    Query query, {
    DocumentReference<Object?>? parent,
  }) {
    listViewPagingController ??= _createListViewController(query, parent);
    if (listViewPagingQuery != query) {
      listViewPagingQuery = query;
      listViewPagingController?.refresh();
    }
    return listViewPagingController!;
  }

  PagingController<DocumentSnapshot?, BillsRecord> _createListViewController(
    Query query,
    DocumentReference<Object?>? parent,
  ) {
    final controller =
        PagingController<DocumentSnapshot?, BillsRecord>(firstPageKey: null);
    return controller
      ..addPageRequestListener(
        (nextPageMarker) => queryBillsRecordPage(
          queryBuilder: (_) => listViewPagingQuery ??= query,
          nextPageMarker: nextPageMarker,
          streamSubscriptions: listViewStreamSubscriptions,
          controller: controller,
          pageSize: 25,
          isStream: true,
        ),
      );
  }
}
