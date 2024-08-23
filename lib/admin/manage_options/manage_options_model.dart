import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/new_option/new_option_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'manage_options_widget.dart' show ManageOptionsWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
