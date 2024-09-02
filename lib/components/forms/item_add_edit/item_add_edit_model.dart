import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'item_add_edit_widget.dart' show ItemAddEditWidget;
import 'package:flutter/material.dart';

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
