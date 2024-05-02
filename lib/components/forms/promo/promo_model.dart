import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'promo_widget.dart' show PromoWidget;
import 'package:flutter/material.dart';

class PromoModel extends FlutterFlowModel<PromoWidget> {
  ///  Local state fields for this component.

  bool promoOn = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in Promo widget.
  HotelSettingsRecord? settings;
  // State field(s) for Switch widget.
  bool switchValue = true;
  // State field(s) for detail widget.
  FocusNode? detailFocusNode;
  TextEditingController? detailTextController;
  String? Function(BuildContext, String?)? detailTextControllerValidator;
  // State field(s) for percent widget.
  FocusNode? percentFocusNode;
  TextEditingController? percentTextController;
  String? Function(BuildContext, String?)? percentTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    detailFocusNode?.dispose();
    detailTextController?.dispose();

    percentFocusNode?.dispose();
    percentTextController?.dispose();
  }
}
