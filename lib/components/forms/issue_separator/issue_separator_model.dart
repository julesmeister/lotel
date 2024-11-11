import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'issue_separator_widget.dart' show IssueSeparatorWidget;
import 'package:flutter/material.dart';

class IssueSeparatorModel extends FlutterFlowModel<IssueSeparatorWidget> {
  ///  Local state fields for this page.

  List<String> words = [];
  void addToWords(String item) => words.add(item);
  void removeFromWords(String item) => words.remove(item);
  void removeAtIndexFromWords(int index) => words.removeAt(index);
  void insertAtIndexInWords(int index, String item) =>
      words.insert(index, item);
  void updateWordsAtIndex(int index, Function(String) updateFn) =>
      words[index] = updateFn(words[index]);

  int issueCount = 1;

  List<String> newIssues = [];
  void addToNewIssues(String item) => newIssues.add(item);
  void removeFromNewIssues(String item) => newIssues.remove(item);
  void removeAtIndexFromNewIssues(int index) => newIssues.removeAt(index);
  void insertAtIndexInNewIssues(int index, String item) =>
      newIssues.insert(index, item);
  void updateNewIssuesAtIndex(int index, Function(String) updateFn) =>
      newIssues[index] = updateFn(newIssues[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for choices widget.
  FormFieldController<List<String>>? choicesValueController;
  List<String>? get choicesValues => choicesValueController?.value;
  set choicesValues(List<String>? val) => choicesValueController?.value = val;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
