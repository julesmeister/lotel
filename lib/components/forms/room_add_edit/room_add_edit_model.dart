import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'room_add_edit_widget.dart' show RoomAddEditWidget;
import 'package:flutter/material.dart';

class RoomAddEditModel extends FlutterFlowModel<RoomAddEditWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for number widget.
  FocusNode? numberFocusNode;
  TextEditingController? numberTextController;
  String? Function(BuildContext, String?)? numberTextControllerValidator;
  // State field(s) for price widget.
  FocusNode? priceFocusNode;
  TextEditingController? priceTextController;
  String? Function(BuildContext, String?)? priceTextControllerValidator;
  // State field(s) for capacity widget.
  FocusNode? capacityFocusNode;
  TextEditingController? capacityTextController;
  String? Function(BuildContext, String?)? capacityTextControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Row widget.
  RoomsRecord? createRoom;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    numberFocusNode?.dispose();
    numberTextController?.dispose();

    priceFocusNode?.dispose();
    priceTextController?.dispose();

    capacityFocusNode?.dispose();
    capacityTextController?.dispose();
  }
}
