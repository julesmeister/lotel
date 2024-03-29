import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'missing_inventory_widget.dart' show MissingInventoryWidget;
import 'package:flutter/material.dart';

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

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    descFocusNode?.dispose();
    descController?.dispose();

    quantityFocusNode?.dispose();
    quantityController?.dispose();

    whyFocusNode?.dispose();
    whyController?.dispose();
  }
}
