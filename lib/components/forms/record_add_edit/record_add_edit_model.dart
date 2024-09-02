import '/flutter_flow/flutter_flow_util.dart';
import 'record_add_edit_widget.dart' show RecordAddEditWidget;
import 'package:flutter/material.dart';

class RecordAddEditModel extends FlutterFlowModel<RecordAddEditWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for details widget.
  FocusNode? detailsFocusNode1;
  TextEditingController? detailsTextController1;
  String? Function(BuildContext, String?)? detailsTextController1Validator;
  // State field(s) for details widget.
  final detailsKey2 = GlobalKey();
  FocusNode? detailsFocusNode2;
  TextEditingController? detailsTextController2;
  String? detailsSelectedOption2;
  String? Function(BuildContext, String?)? detailsTextController2Validator;
  // State field(s) for details widget.
  final detailsKey3 = GlobalKey();
  FocusNode? detailsFocusNode3;
  TextEditingController? detailsTextController3;
  String? detailsSelectedOption3;
  String? Function(BuildContext, String?)? detailsTextController3Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    detailsFocusNode1?.dispose();
    detailsTextController1?.dispose();

    detailsFocusNode2?.dispose();

    detailsFocusNode3?.dispose();
  }
}
