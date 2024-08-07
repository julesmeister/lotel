import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'option_to_staff_widget.dart' show OptionToStaffWidget;
import 'package:flutter/material.dart';

class OptionToStaffModel extends FlutterFlowModel<OptionToStaffWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in replaceWidget widget.
  StaffsRecord? staff;
  // Stores action output result for [Backend Call - Read Document] action in replaceWidget widget.
  StaffsRecord? thisSaff;
  // Stores action output result for [Firestore Query - Query a collection] action in replaceWidget widget.
  int? isUserAlready;
  // Stores action output result for [Backend Call - Read Document] action in replaceWidget widget.
  StaffsRecord? stafftoFire;
  // Stores action output result for [Firestore Query - Query a collection] action in replaceWidget widget.
  UsersRecord? userToFire;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
