import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/forms/change_amount/change_amount_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'pay_pending_partially_widget.dart' show PayPendingPartiallyWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PayPendingPartiallyModel
    extends FlutterFlowModel<PayPendingPartiallyWidget> {
  ///  Local state fields for this component.

  int loop = 0;

  double total = 0.0;

  List<PayPendingStruct> pendings = [];
  void addToPendings(PayPendingStruct item) => pendings.add(item);
  void removeFromPendings(PayPendingStruct item) => pendings.remove(item);
  void removeAtIndexFromPendings(int index) => pendings.removeAt(index);
  void insertAtIndexInPendings(int index, PayPendingStruct item) =>
      pendings.insert(index, item);
  void updatePendingsAtIndex(int index, Function(PayPendingStruct) updateFn) =>
      pendings[index] = updateFn(pendings[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Bottom Sheet - ChangeAmount] action in Row widget.
  double? amount;
  // State field(s) for Checkbox widget.
  Map<PayPendingStruct, bool> checkboxValueMap = {};
  List<PayPendingStruct> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  // Stores action output result for [Backend Call - Read Document] action in Row widget.
  BookingsRecord? booking;
  // Stores action output result for [Backend Call - Read Document] action in Row widget.
  RoomsRecord? room;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
