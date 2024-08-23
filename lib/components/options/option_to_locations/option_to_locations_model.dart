import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/add_edit_c_r/add_edit_c_r_widget.dart';
import '/components/forms/add_edit_location/add_edit_location_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'option_to_locations_widget.dart' show OptionToLocationsWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OptionToLocationsModel extends FlutterFlowModel<OptionToLocationsWidget> {
  ///  Local state fields for this component.

  int loop = 0;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in changeDetails widget.
  LocationsRecord? location;
  // Stores action output result for [Backend Call - Read Document] action in changeDetails widget.
  ComfortRoomsRecord? cr;
  // Stores action output result for [Backend Call - Read Document] action in changeDetails widget.
  LocationsRecord? loc;
  // Stores action output result for [Backend Call - Read Document] action in changeDetails widget.
  LocationsRecord? loca;
  // Stores action output result for [Firestore Query - Query a collection] action in remove widget.
  List<ReplacementRecord>? replacementofLocations;
  // Stores action output result for [Firestore Query - Query a collection] action in remove widget.
  List<ReplacementRecord>? replacementsofCR;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
