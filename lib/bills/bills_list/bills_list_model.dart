import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/change_date/change_date_widget.dart';
import '/components/options/option_to_bill/option_to_bill_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:math';
import '/flutter_flow/custom_functions.dart' as functions;
import 'bills_list_widget.dart' show BillsListWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in billsList widget.
  List<BillsRecord>? allBills;
  // Stores action output result for [Firestore Query - Query a collection] action in billsList widget.
  List<OptionsRecord>? additional;
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
