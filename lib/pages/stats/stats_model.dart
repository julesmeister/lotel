import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'stats_widget.dart' show StatsWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class StatsModel extends FlutterFlowModel<StatsWidget> {
  ///  Local state fields for this page.

  String month = 'October';

  String year = '2024';

  double net = 0.0;

  double expenses = 0.0;

  double salaries = 0.0;

  List<RoomUsageStruct> roomUsage = [];
  void addToRoomUsage(RoomUsageStruct item) => roomUsage.add(item);
  void removeFromRoomUsage(RoomUsageStruct item) => roomUsage.remove(item);
  void removeAtIndexFromRoomUsage(int index) => roomUsage.removeAt(index);
  void insertAtIndexInRoomUsage(int index, RoomUsageStruct item) =>
      roomUsage.insert(index, item);
  void updateRoomUsageAtIndex(int index, Function(RoomUsageStruct) updateFn) =>
      roomUsage[index] = updateFn(roomUsage[index]);

  LineGraphStruct? goodsLine;
  void updateGoodsLineStruct(Function(LineGraphStruct) updateFn) =>
      updateFn(goodsLine ??= LineGraphStruct());

  LineGraphStruct? roomLine;
  void updateRoomLineStruct(Function(LineGraphStruct) updateFn) =>
      updateFn(roomLine ??= LineGraphStruct());

  double rooms = 0.0;

  double goods = 0.0;

  DocumentReference? statsRef;

  double rent = 0.0;

  String hotel = 'All';

  List<StatsRecord> stats = [];
  void addToStats(StatsRecord item) => stats.add(item);
  void removeFromStats(StatsRecord item) => stats.remove(item);
  void removeAtIndexFromStats(int index) => stats.removeAt(index);
  void insertAtIndexInStats(int index, StatsRecord item) =>
      stats.insert(index, item);
  void updateStatsAtIndex(int index, Function(StatsRecord) updateFn) =>
      stats[index] = updateFn(stats[index]);

  double groceryExpenses = 0.0;

  double bills = 0.0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in Stats widget.
  int? initCount;
  // Stores action output result for [Firestore Query - Query a collection] action in Stats widget.
  List<StatsRecord>? currentStats;
  // State field(s) for month widget.
  String? monthValue;
  FormFieldController<String>? monthValueController;
  // Stores action output result for [Firestore Query - Query a collection] action in month widget.
  int? initStatsCountCopy;
  // Stores action output result for [Firestore Query - Query a collection] action in month widget.
  List<StatsRecord>? foundMonthDoc;
  // State field(s) for year widget.
  String? yearValue;
  FormFieldController<String>? yearValueController;
  // Stores action output result for [Firestore Query - Query a collection] action in year widget.
  int? initStatsCountCopyCopy;
  // Stores action output result for [Firestore Query - Query a collection] action in year widget.
  List<StatsRecord>? foundYearDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in Text widget.
  List<TransactionsRecord>? bookingTransactionsOnly;
  // Stores action output result for [Firestore Query - Query a collection] action in Text widget.
  List<TransactionsRecord>? goodsTransactionsOnly;
  // Stores action output result for [Firestore Query - Query a collection] action in Text widget.
  List<TransactionsRecord>? expenseTransactionsOnly;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
