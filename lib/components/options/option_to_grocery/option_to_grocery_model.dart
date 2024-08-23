import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/edit_grocery/edit_grocery_widget.dart';
import '/components/forms/new_grocery/new_grocery_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'option_to_grocery_widget.dart' show OptionToGroceryWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OptionToGroceryModel extends FlutterFlowModel<OptionToGroceryWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in mark widget.
  GroceriesRecord? groceryToTrack;
  // Stores action output result for [Firestore Query - Query a collection] action in mark widget.
  int? countGrr;
  // Stores action output result for [Firestore Query - Query a collection] action in mark widget.
  GoodsRevenueRatioRecord? lastGrr;
  // Stores action output result for [Backend Call - Read Document] action in mark widget.
  StatsRecord? statsRef;
  // Stores action output result for [Backend Call - Read Document] action in replaceWidget widget.
  GroceriesRecord? grocery;
  // Stores action output result for [Firestore Query - Query a collection] action in replaceWidget widget.
  int? countGrrr;
  // Stores action output result for [Firestore Query - Query a collection] action in replaceWidget widget.
  GoodsRevenueRatioRecord? lastGrrr;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
