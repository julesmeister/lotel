import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'locations_widget.dart' show LocationsWidget;
import 'package:flutter/material.dart';

class LocationsModel extends FlutterFlowModel<LocationsWidget> {
  ///  Local state fields for this page.

  int loop = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in Locations widget.
  List<RoomsRecord>? allRooms;
  // Stores action output result for [Firestore Query - Query a collection] action in Locations widget.
  List<LocationsRecord>? allLocations;
  // Stores action output result for [Backend Call - Create Document] action in Locations widget.
  LocationsRecord? newRoom;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // Stores action output result for [Backend Call - Read Document] action in Icon widget.
  LocationsRecord? loc;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
