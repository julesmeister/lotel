import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/add_edit_c_r/add_edit_c_r_widget.dart';
import '/components/forms/add_edit_location/add_edit_location_widget.dart';
import '/components/options/option_to_c_r/option_to_c_r_widget.dart';
import '/components/options/option_to_locations/option_to_locations_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import '/flutter_flow/request_manager.dart';

import 'locations_widget.dart' show LocationsWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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

  /// Query cache managers for this widget.

  final _areasListManager = StreamRequestManager<List<LocationsRecord>>();
  Stream<List<LocationsRecord>> areasList({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<LocationsRecord>> Function() requestFn,
  }) =>
      _areasListManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearAreasListCache() => _areasListManager.clear();
  void clearAreasListCacheKey(String? uniqueKey) =>
      _areasListManager.clearRequest(uniqueKey);

  final _comfortRoomsManager = StreamRequestManager<List<ComfortRoomsRecord>>();
  Stream<List<ComfortRoomsRecord>> comfortRooms({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<ComfortRoomsRecord>> Function() requestFn,
  }) =>
      _comfortRoomsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearComfortRoomsCache() => _comfortRoomsManager.clear();
  void clearComfortRoomsCacheKey(String? uniqueKey) =>
      _comfortRoomsManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();

    /// Dispose query cache managers for this widget.

    clearAreasListCache();

    clearComfortRoomsCache();
  }
}
