import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'option_to_booking_widget.dart' show OptionToBookingWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OptionToBookingModel extends FlutterFlowModel<OptionToBookingWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in extend widget.
  HotelSettingsRecord? hotelSettings;
  // Stores action output result for [Backend Call - Read Document] action in extend widget.
  RoomsRecord? room;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
