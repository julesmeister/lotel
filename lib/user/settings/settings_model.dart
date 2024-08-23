import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/forms/name_edit/name_edit_widget.dart';
import '/components/options/option_to_logout/option_to_logout_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import 'settings_widget.dart' show SettingsWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingsModel extends FlutterFlowModel<SettingsWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  List<StatsRecord>? fireStat;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  HotelSettingsRecord? hotelSetting;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  int? countUncollected;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
