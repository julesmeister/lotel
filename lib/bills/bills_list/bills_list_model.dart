import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'bills_list_widget.dart' show BillsListWidget;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

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

  String year = '2024';

  List<BillsRecord> showBills = [];
  void addToShowBills(BillsRecord item) => showBills.add(item);
  void removeFromShowBills(BillsRecord item) => showBills.remove(item);
  void removeAtIndexFromShowBills(int index) => showBills.removeAt(index);
  void insertAtIndexInShowBills(int index, BillsRecord item) =>
      showBills.insert(index, item);
  void updateShowBillsAtIndex(int index, Function(BillsRecord) updateFn) =>
      showBills[index] = updateFn(showBills[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in billsList widget.
  List<BillsRecord>? allBills;
  // Stores action output result for [Firestore Query - Query a collection] action in billsList widget.
  List<OptionsRecord>? additional;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  List<BillsRecord>? hotelBills;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  List<BillsRecord>? prevBills;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  List<BillsRecord>? nextBills;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // Stores action output result for [Bottom Sheet - ChangeDate] action in Column widget.
  DateTime? adjustedDate;
  // Stores action output result for [Firestore Query - Query a collection] action in Column widget.
  StatsRecord? prevStats;
  // Stores action output result for [Firestore Query - Query a collection] action in Column widget.
  StatsRecord? belongingStats;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
