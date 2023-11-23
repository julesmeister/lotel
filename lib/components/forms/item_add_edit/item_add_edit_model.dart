import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_autocomplete_options_list.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'item_add_edit_widget.dart' show ItemAddEditWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ItemAddEditModel extends FlutterFlowModel<ItemAddEditWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for desc widget.
  FocusNode? descFocusNode;
  TextEditingController? descController;
  String? Function(BuildContext, String?)? descControllerValidator;
  // State field(s) for price widget.
  FocusNode? priceFocusNode;
  TextEditingController? priceController;
  String? Function(BuildContext, String?)? priceControllerValidator;
  // State field(s) for quantity widget.
  FocusNode? quantityFocusNode;
  TextEditingController? quantityController;
  String? Function(BuildContext, String?)? quantityControllerValidator;
  // State field(s) for why widget.
  FocusNode? whyFocusNode;
  TextEditingController? whyController;
  String? Function(BuildContext, String?)? whyControllerValidator;
  // State field(s) for category widget.
  final categoryKey = GlobalKey();
  FocusNode? categoryFocusNode;
  TextEditingController? categoryController;
  String? categorySelectedOption;
  String? Function(BuildContext, String?)? categoryControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Row widget.
  GoodsRecord? createPayload;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    descFocusNode?.dispose();
    descController?.dispose();

    priceFocusNode?.dispose();
    priceController?.dispose();

    quantityFocusNode?.dispose();
    quantityController?.dispose();

    whyFocusNode?.dispose();
    whyController?.dispose();

    categoryFocusNode?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
