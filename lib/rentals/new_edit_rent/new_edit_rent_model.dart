import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/new_space/new_space_widget.dart';
import '/components/space_options/space_options_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'new_edit_rent_widget.dart' show NewEditRentWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NewEditRentModel extends FlutterFlowModel<NewEditRentWidget> {
  ///  Local state fields for this page.

  DateTime? date;

  String fortnight = '1st';

  bool edit = false;

  String status = 'ongoing';

  List<SpacesRecord> spaces = [];
  void addToSpaces(SpacesRecord item) => spaces.add(item);
  void removeFromSpaces(SpacesRecord item) => spaces.remove(item);
  void removeAtIndexFromSpaces(int index) => spaces.removeAt(index);
  void insertAtIndexInSpaces(int index, SpacesRecord item) =>
      spaces.insert(index, item);
  void updateSpacesAtIndex(int index, Function(SpacesRecord) updateFn) =>
      spaces[index] = updateFn(spaces[index]);

  DocumentReference? ref;

  int loopSpacesCounter = 0;

  List<SpacesRecord> spaceToDelete = [];
  void addToSpaceToDelete(SpacesRecord item) => spaceToDelete.add(item);
  void removeFromSpaceToDelete(SpacesRecord item) => spaceToDelete.remove(item);
  void removeAtIndexFromSpaceToDelete(int index) =>
      spaceToDelete.removeAt(index);
  void insertAtIndexInSpaceToDelete(int index, SpacesRecord item) =>
      spaceToDelete.insert(index, item);
  void updateSpaceToDeleteAtIndex(int index, Function(SpacesRecord) updateFn) =>
      spaceToDelete[index] = updateFn(spaceToDelete[index]);

  SpacesRecord? tempSpace;

  double withholdingtax = 0.0;

  bool changeableTax = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - Read Document] action in NewEditRent widget.
  RentalsRecord? existingRental;
  // Stores action output result for [Firestore Query - Query a collection] action in NewEditRent widget.
  List<SpacesRecord>? existingSpaces;
  // Stores action output result for [Bottom Sheet - NewSpace] action in IconButton widget.
  SpacesRecord? space;
  // State field(s) for withHoldingTax widget.
  FocusNode? withHoldingTaxFocusNode;
  TextEditingController? withHoldingTaxController;
  String? Function(BuildContext, String?)? withHoldingTaxControllerValidator;
  // Stores action output result for [Bottom Sheet - NewSpace] action in listContainer widget.
  SpacesRecord? updatedSpace;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  RentalsRecord? newRent;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    withHoldingTaxFocusNode?.dispose();
    withHoldingTaxController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
