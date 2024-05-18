import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'add_extra_bed_widget.dart' show AddExtraBedWidget;
import 'package:flutter/material.dart';

class AddExtraBedModel extends FlutterFlowModel<AddExtraBedWidget> {
  ///  Local state fields for this component.

  String operator = '+';

  double bedPrice = 0.0;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in AddExtraBed widget.
  HotelSettingsRecord? hotelSetting;
  // State field(s) for number widget.
  FocusNode? numberFocusNode;
  TextEditingController? numberTextController;
  String? Function(BuildContext, String?)? numberTextControllerValidator;
  // Stores action output result for [Backend Call - Read Document] action in Row widget.
  RoomsRecord? room;
  // Stores action output result for [Backend Call - Create Document] action in Row widget.
  TransactionsRecord? trans;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    numberFocusNode?.dispose();
    numberTextController?.dispose();
  }
}
