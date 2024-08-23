import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'list_of_names_widget.dart' show ListOfNamesWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ListOfNamesModel extends FlutterFlowModel<ListOfNamesWidget> {
  ///  Local state fields for this component.

  List<String> names = [];
  void addToNames(String item) => names.add(item);
  void removeFromNames(String item) => names.remove(item);
  void removeAtIndexFromNames(int index) => names.removeAt(index);
  void insertAtIndexInNames(int index, String item) =>
      names.insert(index, item);
  void updateNamesAtIndex(int index, Function(String) updateFn) =>
      names[index] = updateFn(names[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in ListOfNames widget.
  List<StaffsRecord>? staffs;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
