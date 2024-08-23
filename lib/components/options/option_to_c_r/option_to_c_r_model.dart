import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/add_edit_c_r/add_edit_c_r_widget.dart';
import '/components/forms/add_edit_location/add_edit_location_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'option_to_c_r_widget.dart' show OptionToCRWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OptionToCRModel extends FlutterFlowModel<OptionToCRWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in changeDetails widget.
  LocationsRecord? location;
  // Stores action output result for [Backend Call - Read Document] action in changeDetails widget.
  ComfortRoomsRecord? cr;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
