import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'option_to_locations_widget.dart' show OptionToLocationsWidget;
import 'package:flutter/material.dart';

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
