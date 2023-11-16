import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'check_in_widget.dart' show CheckInWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CheckInModel extends FlutterFlowModel<CheckInWidget> {
  ///  Local state fields for this page.

  bool paid = true;

  double price = 0.0;

  int? startingNights;

  String? startingBeds;

  List<DocumentReference> pendings = [];
  void addToPendings(DocumentReference item) => pendings.add(item);
  void removeFromPendings(DocumentReference item) => pendings.remove(item);
  void removeAtIndexFromPendings(int index) => pendings.removeAt(index);
  void insertAtIndexInPendings(int index, DocumentReference item) =>
      pendings.insert(index, item);
  void updatePendingsAtIndex(int index, Function(DocumentReference) updateFn) =>
      pendings[index] = updateFn(pendings[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Read Document] action in CheckIn widget.
  RoomsRecord? room;
  // State field(s) for nights widget.
  int? nightsValue;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for beds widget.
  String? bedsValue;
  FormFieldController<List<String>>? bedsValueController;
  // State field(s) for guests widget.
  String? guestsValue;
  FormFieldController<List<String>>? guestsValueController;
  // Stores action output result for [Backend Call - Create Document] action in saveGuest widget.
  TransactionsRecord? newExtPending;
  // Stores action output result for [Backend Call - Create Document] action in saveGuest widget.
  TransactionsRecord? newRefundPending;
  // Stores action output result for [Backend Call - Create Document] action in saveGuest widget.
  BookingsRecord? savedBooking;
  // Stores action output result for [Backend Call - Create Document] action in saveGuest widget.
  TransactionsRecord? newPending;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
