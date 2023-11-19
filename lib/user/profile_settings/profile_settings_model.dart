import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/name_edit/name_edit_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/request_manager.dart';

import 'profile_settings_widget.dart' show ProfileSettingsWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileSettingsModel extends FlutterFlowModel<ProfileSettingsWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  List<StatsRecord>? fireStat;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue1;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue2;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  StatsRecord? serenityStat;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  StatsRecord? lifestyleStat;

  /// Query cache managers for this widget.

  final _adminManager = StreamRequestManager<List<HotelSettingsRecord>>();
  Stream<List<HotelSettingsRecord>> admin({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<HotelSettingsRecord>> Function() requestFn,
  }) =>
      _adminManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearAdminCache() => _adminManager.clear();
  void clearAdminCacheKey(String? uniqueKey) =>
      _adminManager.clearRequest(uniqueKey);

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    /// Dispose query cache managers for this widget.

    clearAdminCache();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
