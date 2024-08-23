import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/change_date/change_date_widget.dart';
import '/components/options/option_to_replacement/option_to_replacement_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import '/flutter_flow/custom_functions.dart' as functions;
import 'all_replacements_widget.dart' show AllReplacementsWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AllReplacementsModel extends FlutterFlowModel<AllReplacementsWidget> {
  ///  Local state fields for this page.

  String year = '2024';

  bool showMonthPicker = true;

  int loop = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Bottom Sheet - ChangeDate] action in Column widget.
  DateTime? adjustedFixDateCopy;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
