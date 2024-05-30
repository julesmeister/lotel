import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'pay_pending_partially_widget.dart' show PayPendingPartiallyWidget;
import 'package:flutter/material.dart';

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
