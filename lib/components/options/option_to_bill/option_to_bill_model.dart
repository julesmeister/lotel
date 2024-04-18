import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'option_to_bill_widget.dart' show OptionToBillWidget;
import 'package:flutter/material.dart';

class OptionToBillModel extends FlutterFlowModel<OptionToBillWidget> {
  ///  Local state fields for this component.

  DocumentReference? stats;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in changeDetails widget.
  BillsRecord? billToChange;
  // Stores action output result for [Firestore Query - Query a collection] action in bookmark widget.
  int? existingBill;
  // Stores action output result for [Firestore Query - Query a collection] action in remove widget.
  StatsRecord? statsBillBelong;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
