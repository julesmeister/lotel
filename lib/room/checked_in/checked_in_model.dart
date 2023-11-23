import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/options/option_to_booking/option_to_booking_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/request_manager.dart';

import 'checked_in_widget.dart' show CheckedInWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CheckedInModel extends FlutterFlowModel<CheckedInWidget> {
  ///  Local state fields for this page.

  bool showChangePrice = false;

  bool showMoveRoom = false;

  List<DocumentReference> pendings = [];
  void addToPendings(DocumentReference item) => pendings.add(item);
  void removeFromPendings(DocumentReference item) => pendings.remove(item);
  void removeAtIndexFromPendings(int index) => pendings.removeAt(index);
  void insertAtIndexInPendings(int index, DocumentReference item) =>
      pendings.insert(index, item);
  void updatePendingsAtIndex(int index, Function(DocumentReference) updateFn) =>
      pendings[index] = updateFn(pendings[index]);

  int loopPendingCounter = 0;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for ChoiceChips widget.
  String? choiceChipsValue;
  FormFieldController<List<String>>? choiceChipsValueController;
  // Stores action output result for [Firestore Query - Query a collection] action in ChoiceChips widget.
  TransactionsRecord? transaction;
  // Stores action output result for [Bottom Sheet - OptionToBooking] action in Button widget.
  bool? toChangePrice;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  TransactionsRecord? pendingTrans;
  // State field(s) for priceChangedescription widget.
  String? priceChangedescriptionValue;
  FormFieldController<String>? priceChangedescriptionValueController;
  // State field(s) for newPrice widget.
  FocusNode? newPriceFocusNode;
  TextEditingController? newPriceController;
  String? Function(BuildContext, String?)? newPriceControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in saveChangedPrice widget.
  HotelSettingsRecord? hotelSetting;
  // Stores action output result for [Backend Call - Create Document] action in saveChangedPrice widget.
  TransactionsRecord? newPending;

  /// Query cache managers for this widget.

  final _bookingDetailsManager = StreamRequestManager<BookingsRecord>();
  Stream<BookingsRecord> bookingDetails({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<BookingsRecord> Function() requestFn,
  }) =>
      _bookingDetailsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearBookingDetailsCache() => _bookingDetailsManager.clear();
  void clearBookingDetailsCacheKey(String? uniqueKey) =>
      _bookingDetailsManager.clearRequest(uniqueKey);

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    newPriceFocusNode?.dispose();
    newPriceController?.dispose();

    /// Dispose query cache managers for this widget.

    clearBookingDetailsCache();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
