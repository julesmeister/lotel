import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'new_grocery_widget.dart' show NewGroceryWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
    remarkTextController?.dispose();

    amountFocusNode?.dispose();
    amountTextController?.dispose();
  }
}
