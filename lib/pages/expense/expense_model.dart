import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/request_manager.dart';

import 'expense_widget.dart' show ExpenseWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ExpenseModel extends FlutterFlowModel<ExpenseWidget> {
  ///  Local state fields for this page.

  DocumentReference? staffSelected;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for amount widget.
  FocusNode? amountFocusNode;
  TextEditingController? amountController;
  String? Function(BuildContext, String?)? amountControllerValidator;
  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionController;
  String? Function(BuildContext, String?)? descriptionControllerValidator;
  // State field(s) for choices widget.
  String? choicesValue;
  FormFieldController<List<String>>? choicesValueController;
  // State field(s) for selectedName widget.
  String? selectedNameValue;
  FormFieldController<String>? selectedNameValueController;

  /// Query cache managers for this widget.

  final _staffsCashAdvanceManager = StreamRequestManager<List<StaffsRecord>>();
  Stream<List<StaffsRecord>> staffsCashAdvance({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<StaffsRecord>> Function() requestFn,
  }) =>
      _staffsCashAdvanceManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearStaffsCashAdvanceCache() => _staffsCashAdvanceManager.clear();
  void clearStaffsCashAdvanceCacheKey(String? uniqueKey) =>
      _staffsCashAdvanceManager.clearRequest(uniqueKey);

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    amountFocusNode?.dispose();
    amountController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionController?.dispose();

    /// Dispose query cache managers for this widget.

    clearStaffsCashAdvanceCache();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
