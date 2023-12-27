import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'option_to_grocery_widget.dart' show OptionToGroceryWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OptionToGroceryModel extends FlutterFlowModel<OptionToGroceryWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in replaceWidget widget.
  GroceriesRecord? groceryToTrack;
  // Stores action output result for [Firestore Query - Query a collection] action in replaceWidget widget.
  int? countGrr;
  // Stores action output result for [Firestore Query - Query a collection] action in replaceWidget widget.
  GoodsRevenueRatioRecord? lastGrr;
  // Stores action output result for [Backend Call - Read Document] action in replaceWidget widget.
  GroceriesRecord? grocery;
  // Stores action output result for [Firestore Query - Query a collection] action in replaceWidget widget.
  int? countGrrr;
  // Stores action output result for [Firestore Query - Query a collection] action in replaceWidget widget.
  GoodsRevenueRatioRecord? lastGrrr;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
