import '/flutter_flow/flutter_flow_util.dart';
import 'salary_edit_widget.dart' show SalaryEditWidget;
import 'package:flutter/material.dart';

class SalaryEditModel extends FlutterFlowModel<SalaryEditWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for salary widget.
  FocusNode? salaryFocusNode;
  TextEditingController? salaryTextController;
  String? Function(BuildContext, String?)? salaryTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    salaryFocusNode?.dispose();
    salaryTextController?.dispose();
  }
}
