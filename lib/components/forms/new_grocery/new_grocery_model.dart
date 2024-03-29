import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'new_grocery_widget.dart' show NewGroceryWidget;
import 'package:flutter/material.dart';

class NewGroceryModel extends FlutterFlowModel<NewGroceryWidget> {
  ///  Local state fields for this component.

  bool startCountingRevenue = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for remark widget.
  FocusNode? remarkFocusNode;
  TextEditingController? remarkController;
  String? Function(BuildContext, String?)? remarkControllerValidator;
  // State field(s) for amount widget.
  FocusNode? amountFocusNode;
  TextEditingController? amountController;
  String? Function(BuildContext, String?)? amountControllerValidator;
  // State field(s) for Switch widget.
  bool? switchValue;
  // Stores action output result for [Firestore Query - Query a collection] action in Row widget.
  int? countGrr;
  // Stores action output result for [Firestore Query - Query a collection] action in Row widget.
  GoodsRevenueRatioRecord? lastGrr;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    remarkFocusNode?.dispose();
    remarkController?.dispose();

    amountFocusNode?.dispose();
    amountController?.dispose();
  }
}
