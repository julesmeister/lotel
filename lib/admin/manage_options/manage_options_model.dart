import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'manage_options_widget.dart' show ManageOptionsWidget;
import 'package:flutter/material.dart';

class ManageOptionsModel extends FlutterFlowModel<ManageOptionsWidget> {
  ///  Local state fields for this page.

  List<DocumentReference> selectedChoice = [];
  void addToSelectedChoice(DocumentReference item) => selectedChoice.add(item);
  void removeFromSelectedChoice(DocumentReference item) =>
      selectedChoice.remove(item);
  void removeAtIndexFromSelectedChoice(int index) =>
      selectedChoice.removeAt(index);
  void insertAtIndexInSelectedChoice(int index, DocumentReference item) =>
      selectedChoice.insert(index, item);
  void updateSelectedChoiceAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      selectedChoice[index] = updateFn(selectedChoice[index]);

  int loop = 0;

  bool showExpenses = true;

  bool showBills = true;

  ///  State fields for stateful widgets in this page.

  // State field(s) for CheckboxListTile widget.
  Map<OptionsRecord, bool> checkboxListTileValueMap1 = {};
  List<OptionsRecord> get checkboxListTileCheckedItems1 =>
      checkboxListTileValueMap1.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  // State field(s) for CheckboxListTile widget.
  Map<OptionsRecord, bool> checkboxListTileValueMap2 = {};
  List<OptionsRecord> get checkboxListTileCheckedItems2 =>
      checkboxListTileValueMap2.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
