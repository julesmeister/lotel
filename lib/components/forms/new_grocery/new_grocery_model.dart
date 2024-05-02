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
  TextEditingController? remarkTextController;
  String? Function(BuildContext, String?)? remarkTextControllerValidator;
  // State field(s) for amount widget.
  FocusNode? amountFocusNode;
  TextEditingController? amountTextController;
  String? Function(BuildContext, String?)? amountTextControllerValidator;
  // State field(s) for Switch widget.
  bool switchValue = false;
  // Stores action output result for [Firestore Query - Query a collection] action in Row widget.
  int? countGrr;
  // Stores action output result for [Firestore Query - Query a collection] action in Row widget.
  GoodsRevenueRatioRecord? lastGrr;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    remarkFocusNode?.dispose();
    remarkTextController?.dispose();

    amountFocusNode?.dispose();
    amountTextController?.dispose();
  }
}
