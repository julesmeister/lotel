import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'new_grocery_widget.dart' show NewGroceryWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    remarkFocusNode?.dispose();
    remarkController?.dispose();

    amountFocusNode?.dispose();
    amountController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
