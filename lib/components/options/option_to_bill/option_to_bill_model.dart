import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/bill_edit/bill_edit_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'option_to_bill_widget.dart' show OptionToBillWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
