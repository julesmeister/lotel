import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'locations_widget.dart' show LocationsWidget;
import 'package:flutter/material.dart';

class LocationsModel extends FlutterFlowModel<LocationsWidget> {
  ///  Local state fields for this page.

  int loop = 0;

  bool isCR = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // Stores action output result for [Backend Call - Read Document] action in Icon widget.
  ComfortRoomsRecord? cr;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
