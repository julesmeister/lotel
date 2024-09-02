import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/request_manager.dart';

import 'locations_widget.dart' show LocationsWidget;
import 'package:flutter/material.dart';

class LocationsModel extends FlutterFlowModel<LocationsWidget> {
  ///  Local state fields for this page.

  int loop = 0;

  bool isCR = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
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
