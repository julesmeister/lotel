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
import 'metrics_widget.dart' show MetricsWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class MetricsModel extends FlutterFlowModel<MetricsWidget> {
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

  StatsRecord? stat;

  List<MetricsHolderStruct> prevMetrics = [];
  void addToPrevMetrics(MetricsHolderStruct item) => prevMetrics.add(item);
  void removeFromPrevMetrics(MetricsHolderStruct item) =>
      prevMetrics.remove(item);
  void removeAtIndexFromPrevMetrics(int index) => prevMetrics.removeAt(index);
  void insertAtIndexInPrevMetrics(int index, MetricsHolderStruct item) =>
      prevMetrics.insert(index, item);
  void updatePrevMetricsAtIndex(
          int index, Function(MetricsHolderStruct) updateFn) =>
      prevMetrics[index] = updateFn(prevMetrics[index]);

  int loopCounter = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Action Block - UpdateStatsByHotel] action in Container widget.
  String? hotelName;
  // Stores action output result for [Action Block - UpdateStatsByHotel] action in Container widget.
  String? hotelName1;
  // Stores action output result for [Action Block - UpdateStatsByHotel] action in Container widget.
  String? hotelName2;
  // State field(s) for month widget.
  String? monthValue;
  FormFieldController<String>? monthValueController;
  // State field(s) for year widget.
  String? yearValue;
  FormFieldController<String>? yearValueController;
  // Stores action output result for [Firestore Query - Query a collection] action in Text widget.
  List<TransactionsRecord>? bookingTransactionsOnly;
  // Stores action output result for [Firestore Query - Query a collection] action in Text widget.
  List<TransactionsRecord>? expenseTransactionsOnly;
  // Stores action output result for [Firestore Query - Query a collection] action in Text widget.
  List<BillsRecord>? billsOnly;
  // Stores action output result for [Firestore Query - Query a collection] action in Text widget.
  List<TransactionsRecord>? goodsTransactionsOnly;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  StatsRecord? statO;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  List<RoomsRecord>? roomsCheck;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.

  Future updateStatsByDate(
    BuildContext context, {
    required String? year,
    required String? month,
    required String? hotel,
  }) async {
    int? initStatsCount;
    List<StatsRecord>? foundMonthDoc;
    List<StatsRecord>? foundPrevMonthDoc;

    // count
    initStatsCount = await queryStatsRecordCount(
      queryBuilder: (statsRecord) => statsRecord
          .where(
            'month',
            isEqualTo: month,
          )
          .where(
            'year',
            isEqualTo: year,
          )
          .where(
            'hotel',
            isEqualTo: hotel,
          ),
    );
    if (initStatsCount! > 0) {
      // get stats
      foundMonthDoc = await queryStatsRecordOnce(
        queryBuilder: (statsRecord) => statsRecord
            .where(
              'month',
              isEqualTo: month,
            )
            .where(
              'year',
              isEqualTo: year,
            ),
      );
      // get prev stats
      foundPrevMonthDoc = await queryStatsRecordOnce(
        queryBuilder: (statsRecord) => statsRecord
            .where(
              'month',
              isEqualTo: functions.previousMonth(month!),
            )
            .where(
              'year',
              isEqualTo: functions.previousYear(month!, year!),
            ),
      );
      // initialize all stats
      stats = foundMonthDoc!.toList().cast<StatsRecord>();
      // initialize all page vars
      month = month!;
      year = year!;
      expenses = stats
              .where((e) => e.hotel == 'Serenity')
              .toList()
              .first
              .expenses +
          stats.where((e) => e.hotel == 'My Lifestyle').toList().first.expenses;
      salaries = stats
              .where((e) => e.hotel == 'Serenity')
              .toList()
              .first
              .salaries +
          stats.where((e) => e.hotel == 'My Lifestyle').toList().first.salaries;
      goodsLine = functions.mergedLine(
          stats.where((e) => e.hotel == 'Serenity').toList().first.goodsLine,
          stats
              .where((e) => e.hotel == 'My Lifestyle')
              .toList()
              .first
              .goodsLine);
      roomLine = functions.mergedLine(
          stats.where((e) => e.hotel == 'Serenity').toList().first.roomLine,
          stats
              .where((e) => e.hotel == 'My Lifestyle')
              .toList()
              .first
              .roomLine);
      rooms =
          stats.where((e) => e.hotel == 'Serenity').toList().first.roomsIncome +
              stats
                  .where((e) => e.hotel == 'My Lifestyle')
                  .toList()
                  .first
                  .roomsIncome;
      goods =
          stats.where((e) => e.hotel == 'Serenity').toList().first.goodsIncome +
              stats
                  .where((e) => e.hotel == 'My Lifestyle')
                  .toList()
                  .first
                  .goodsIncome;
      hotel = 'All';
      groceryExpenses = stats
              .where((e) => e.hotel == 'Serenity')
              .toList()
              .first
              .groceryExpenses +
          stats
              .where((e) => e.hotel == 'My Lifestyle')
              .toList()
              .first
              .groceryExpenses;
      bills = stats.where((e) => e.hotel == 'Serenity').toList().first.bills +
          stats.where((e) => e.hotel == 'My Lifestyle').toList().first.bills;
      loopCounter = 0;
      prevMetrics = [];
      // set net only
      net = rooms + goods - expenses - salaries - bills;
      while (foundPrevMonthDoc?.length != loopCounter) {
        // create hotel Metric
        addToPrevMetrics(MetricsHolderStruct(
          hotel: foundPrevMonthDoc?[loopCounter]?.hotel,
          rooms: valueOrDefault<double>(
            foundPrevMonthDoc?[loopCounter]?.roomsIncome,
            0.0,
          ),
          goods: valueOrDefault<double>(
            foundPrevMonthDoc?[loopCounter]?.goodsIncome,
            0.0,
          ),
          expenses: valueOrDefault<double>(
            foundPrevMonthDoc?[loopCounter]?.expenses,
            0.0,
          ),
          salaries: valueOrDefault<double>(
            foundPrevMonthDoc?[loopCounter]?.salaries,
            0.0,
          ),
          bills: valueOrDefault<double>(
            foundPrevMonthDoc?[loopCounter]?.bills,
            0.0,
          ),
          net: valueOrDefault<double>(
            foundPrevMonthDoc![loopCounter].roomsIncome +
                foundPrevMonthDoc![loopCounter].goodsIncome -
                foundPrevMonthDoc![loopCounter].expenses -
                foundPrevMonthDoc![loopCounter].salaries -
                foundPrevMonthDoc![loopCounter].bills,
            0.0,
          ),
        ));
        // increment loop
        loopCounter = loopCounter + 1;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Showing stats of ${monthValue} ${yearValue}',
            style: TextStyle(
              color: FlutterFlowTheme.of(context).primaryText,
            ),
          ),
          duration: Duration(milliseconds: 4000),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
    } else {
      // no data yet
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No data yet!',
            style: TextStyle(
              color: FlutterFlowTheme.of(context).info,
            ),
          ),
          duration: Duration(milliseconds: 4000),
          backgroundColor: FlutterFlowTheme.of(context).error,
        ),
      );
    }
  }

  Future<String?> updateStatsByHotel(
    BuildContext context, {
    required String? hotel,
  }) async {
    if (hotel == 'All') {
      // initialize all page vars
      expenses = stats
              .where((e) => e.hotel == 'Serenity')
              .toList()
              .first
              .expenses +
          stats.where((e) => e.hotel == 'My Lifestyle').toList().first.expenses;
      salaries = stats
              .where((e) => e.hotel == 'Serenity')
              .toList()
              .first
              .salaries +
          stats.where((e) => e.hotel == 'My Lifestyle').toList().first.salaries;
      goodsLine = functions.mergedLine(
          stats.where((e) => e.hotel == 'Serenity').toList().first.goodsLine,
          stats
              .where((e) => e.hotel == 'My Lifestyle')
              .toList()
              .first
              .goodsLine);
      roomLine = functions.mergedLine(
          stats.where((e) => e.hotel == 'Serenity').toList().first.roomLine,
          stats
              .where((e) => e.hotel == 'My Lifestyle')
              .toList()
              .first
              .roomLine);
      rooms =
          stats.where((e) => e.hotel == 'Serenity').toList().first.roomsIncome +
              stats
                  .where((e) => e.hotel == 'My Lifestyle')
                  .toList()
                  .first
                  .roomsIncome;
      goods =
          stats.where((e) => e.hotel == 'Serenity').toList().first.goodsIncome +
              stats
                  .where((e) => e.hotel == 'My Lifestyle')
                  .toList()
                  .first
                  .goodsIncome;
      hotel = 'All';
      groceryExpenses = stats
              .where((e) => e.hotel == 'Serenity')
              .toList()
              .first
              .groceryExpenses +
          stats
              .where((e) => e.hotel == 'My Lifestyle')
              .toList()
              .first
              .groceryExpenses;
      bills = stats.where((e) => e.hotel == 'Serenity').toList().first.bills +
          stats.where((e) => e.hotel == 'My Lifestyle').toList().first.bills;
      // initialize net only
      net = rooms + goods - expenses - groceryExpenses - salaries - bills;
    } else {
      // statByHotel
      stat = functions.statByHotel(stats.toList(), hotel!);
      hotel = hotel!;
      // initialize all page vars
      expenses = stat!.expenses;
      salaries = stat!.salaries;
      roomUsage =
          functions.extractRoomUsage(stat!).toList().cast<RoomUsageStruct>();
      goodsLine = stat?.goodsLine;
      roomLine = stat?.roomLine;
      rooms = stat!.roomsIncome;
      goods = stat!.goodsIncome;
      statsRef = stat?.reference;
      net = stat!.roomsIncome +
          stat!.goodsIncome -
          stat!.salaries -
          stat!.expenses -
          stat!.bills -
          stat!.groceryExpenses;
      groceryExpenses = stat!.groceryExpenses;
      bills = stat!.bills;
    }

    return hotel;
  }

  /// Additional helper methods are added here.
}
