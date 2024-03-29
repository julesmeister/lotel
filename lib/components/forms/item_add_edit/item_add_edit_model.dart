import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'item_add_edit_widget.dart' show ItemAddEditWidget;
import 'package:flutter/material.dart';

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

  @override
  void initState(BuildContext context) {}

  @override
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
}
