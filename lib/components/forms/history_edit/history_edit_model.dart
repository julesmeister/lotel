import '/flutter_flow/flutter_flow_util.dart';
import 'history_edit_widget.dart' show HistoryEditWidget;
import 'package:flutter/material.dart';

class HistoryEditModel extends FlutterFlowModel<HistoryEditWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for details widget.
  FocusNode? detailsFocusNode;
  TextEditingController? detailsTextController;
  String? Function(BuildContext, String?)? detailsTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    detailsFocusNode?.dispose();
    detailsTextController?.dispose();
  }
}
