import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'missing_inventory_widget.dart' show MissingInventoryWidget;
import 'package:flutter/material.dart';

class MissingInventoryModel extends FlutterFlowModel<MissingInventoryWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for desc widget.
  FocusNode? descFocusNode;
  TextEditingController? descTextController;
  String? Function(BuildContext, String?)? descTextControllerValidator;
  // State field(s) for quantity widget.
  FocusNode? quantityFocusNode;
  TextEditingController? quantityTextController;
  String? Function(BuildContext, String?)? quantityTextControllerValidator;
  // State field(s) for why widget.
  FocusNode? whyFocusNode;
  TextEditingController? whyTextController;
  String? Function(BuildContext, String?)? whyTextControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in Row widget.
  GoodsRecord? good;
  // Stores action output result for [Backend Call - Create Document] action in Row widget.
  InventoriesRecord? newInventory;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    descFocusNode?.dispose();
    descTextController?.dispose();

    quantityFocusNode?.dispose();
    quantityTextController?.dispose();

    whyFocusNode?.dispose();
    whyTextController?.dispose();
  }
}
