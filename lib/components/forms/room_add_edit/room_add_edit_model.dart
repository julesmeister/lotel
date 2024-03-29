import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'room_add_edit_widget.dart' show RoomAddEditWidget;
import 'package:flutter/material.dart';

class RoomAddEditModel extends FlutterFlowModel<RoomAddEditWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for number widget.
  FocusNode? numberFocusNode;
  TextEditingController? numberController;
  String? Function(BuildContext, String?)? numberControllerValidator;
  // State field(s) for price widget.
  FocusNode? priceFocusNode;
  TextEditingController? priceController;
  String? Function(BuildContext, String?)? priceControllerValidator;
  // State field(s) for capacity widget.
  FocusNode? capacityFocusNode;
  TextEditingController? capacityController;
  String? Function(BuildContext, String?)? capacityControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Row widget.
  RoomsRecord? createRoom;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    numberFocusNode?.dispose();
    numberController?.dispose();

    priceFocusNode?.dispose();
    priceController?.dispose();

    capacityFocusNode?.dispose();
    capacityController?.dispose();
  }
}
