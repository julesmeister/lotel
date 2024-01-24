import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'missing_inventory_widget.dart' show MissingInventoryWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MissingInventoryModel extends FlutterFlowModel<MissingInventoryWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for desc widget.
  FocusNode? descFocusNode;
  TextEditingController? descController;
  String? Function(BuildContext, String?)? descControllerValidator;
  // State field(s) for quantity widget.
  FocusNode? quantityFocusNode;
  TextEditingController? quantityController;
  String? Function(BuildContext, String?)? quantityControllerValidator;
  // State field(s) for why widget.
  FocusNode? whyFocusNode;
  TextEditingController? whyController;
  String? Function(BuildContext, String?)? whyControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in Row widget.
  GoodsRecord? good;
  // Stores action output result for [Backend Call - Create Document] action in Row widget.
  InventoriesRecord? newInventory;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    descFocusNode?.dispose();
    descController?.dispose();

    quantityFocusNode?.dispose();
    quantityController?.dispose();

    whyFocusNode?.dispose();
    whyController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
