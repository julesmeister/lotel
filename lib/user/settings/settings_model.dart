import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'settings_widget.dart' show SettingsWidget;
import 'package:flutter/material.dart';

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
