import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'manage_roles_widget.dart' show ManageRolesWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class ManageRolesModel extends FlutterFlowModel<ManageRolesWidget> {
  ///  Local state fields for this page.

  List<DocumentReference> selectedUsers = [];
  void addToSelectedUsers(DocumentReference item) => selectedUsers.add(item);
  void removeFromSelectedUsers(DocumentReference item) =>
      selectedUsers.remove(item);
  void removeAtIndexFromSelectedUsers(int index) =>
      selectedUsers.removeAt(index);
  void insertAtIndexInSelectedUsers(int index, DocumentReference item) =>
      selectedUsers.insert(index, item);
  void updateSelectedUsersAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      selectedUsers[index] = updateFn(selectedUsers[index]);

  int loopCounter = 0;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for roleList widget.

  PagingController<DocumentSnapshot?, UsersRecord>? roleListPagingController;
  Query? roleListPagingQuery;
  List<StreamSubscription?> roleListStreamSubscriptions = [];

  // State field(s) for CheckboxListTile widget.

  Map<UsersRecord, bool> checkboxListTileValueMap = {};
  List<UsersRecord> get checkboxListTileCheckedItems =>
      checkboxListTileValueMap.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  // State field(s) for selectedRole widget.
  String? selectedRoleValue;
  FormFieldController<String>? selectedRoleValueController;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    roleListStreamSubscriptions.forEach((s) => s?.cancel());
    roleListPagingController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.

  PagingController<DocumentSnapshot?, UsersRecord> setRoleListController(
    Query query, {
    DocumentReference<Object?>? parent,
  }) {
    roleListPagingController ??= _createRoleListController(query, parent);
    if (roleListPagingQuery != query) {
      roleListPagingQuery = query;
      roleListPagingController?.refresh();
    }
    return roleListPagingController!;
  }

  PagingController<DocumentSnapshot?, UsersRecord> _createRoleListController(
    Query query,
    DocumentReference<Object?>? parent,
  ) {
    final controller =
        PagingController<DocumentSnapshot?, UsersRecord>(firstPageKey: null);
    return controller
      ..addPageRequestListener(
        (nextPageMarker) => queryUsersRecordPage(
          queryBuilder: (_) => roleListPagingQuery ??= query,
          nextPageMarker: nextPageMarker,
          streamSubscriptions: roleListStreamSubscriptions,
          controller: controller,
          pageSize: 25,
          isStream: true,
        ),
      );
  }
}
