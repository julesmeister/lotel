import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/change_date/change_date_widget.dart';
import '/components/forms/record_add_edit/record_add_edit_widget.dart';
import '/components/options/list_of_names/list_of_names_widget.dart';
import '/components/options/option_to_record/option_to_record_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'records_list_widget.dart' show RecordsListWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RecordsListModel extends FlutterFlowModel<RecordsListWidget> {
  ///  Local state fields for this page.

  String month = 'February';

  String year = '2024';

  bool showMonthPicker = true;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Bottom Sheet - ChangeDate] action in Column widget.
  DateTime? adjustedFixDateCopy;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
