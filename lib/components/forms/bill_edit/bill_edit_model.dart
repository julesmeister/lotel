import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bill_edit_widget.dart' show BillEditWidget;
import 'package:flutter/material.dart';

class BillEditModel extends FlutterFlowModel<BillEditWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for desc widget.
  FocusNode? descFocusNode;
  TextEditingController? descController;
  String? Function(BuildContext, String?)? descControllerValidator;
  // State field(s) for amount widget.
  FocusNode? amountFocusNode;
  TextEditingController? amountController;
  String? Function(BuildContext, String?)? amountControllerValidator;
  // State field(s) for afterdue widget.
  FocusNode? afterdueFocusNode;
  TextEditingController? afterdueController;
  String? Function(BuildContext, String?)? afterdueControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in Row widget.
  StatsRecord? rightStats;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    descFocusNode?.dispose();
    descController?.dispose();

    amountFocusNode?.dispose();
    amountController?.dispose();

    afterdueFocusNode?.dispose();
    afterdueController?.dispose();
  }
}
