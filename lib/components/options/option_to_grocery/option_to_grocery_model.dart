import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'option_to_grocery_widget.dart' show OptionToGroceryWidget;
import 'package:flutter/material.dart';

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
