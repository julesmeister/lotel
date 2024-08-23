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
  TextEditingController? descTextController;
  String? Function(BuildContext, String?)? descTextControllerValidator;
  // State field(s) for price widget.
  FocusNode? priceFocusNode;
  TextEditingController? priceTextController;
  String? Function(BuildContext, String?)? priceTextControllerValidator;
  // State field(s) for quantity widget.
  FocusNode? quantityFocusNode;
  TextEditingController? quantityTextController;
  String? Function(BuildContext, String?)? quantityTextControllerValidator;
  // State field(s) for why widget.
  FocusNode? whyFocusNode;
  TextEditingController? whyTextController;
  String? Function(BuildContext, String?)? whyTextControllerValidator;
  // State field(s) for category widget.
  final categoryKey = GlobalKey();
  FocusNode? categoryFocusNode;
  TextEditingController? categoryTextController;
  String? categorySelectedOption;
  String? Function(BuildContext, String?)? categoryTextControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Row widget.
  GoodsRecord? createPayload;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    descFocusNode?.dispose();
    descTextController?.dispose();

    priceFocusNode?.dispose();
    priceTextController?.dispose();

    quantityFocusNode?.dispose();
    quantityTextController?.dispose();

    whyFocusNode?.dispose();
    whyTextController?.dispose();

    categoryFocusNode?.dispose();
  }
}
