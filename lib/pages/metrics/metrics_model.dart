import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'metrics_widget.dart' show MetricsWidget;
import 'package:flutter/material.dart';

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

  bool showMonthPicker = false;

  List<TransactionsRecord> transactionsTemp = [];
  void addToTransactionsTemp(TransactionsRecord item) =>
      transactionsTemp.add(item);
  void removeFromTransactionsTemp(TransactionsRecord item) =>
      transactionsTemp.remove(item);
  void removeAtIndexFromTransactionsTemp(int index) =>
      transactionsTemp.removeAt(index);
  void insertAtIndexInTransactionsTemp(int index, TransactionsRecord item) =>
      transactionsTemp.insert(index, item);
  void updateTransactionsTempAtIndex(
          int index, Function(TransactionsRecord) updateFn) =>
      transactionsTemp[index] = updateFn(transactionsTemp[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Action Block - UpdateStatsByHotel] action in Container widget.
  String? hotelName;
  // Stores action output result for [Action Block - UpdateStatsByHotel] action in Container widget.
  String? hotelName1;
  // Stores action output result for [Action Block - UpdateStatsByHotel] action in Container widget.
  String? hotelName2;
  // Stores action output result for [Firestore Query - Query a collection] action in roomsCard widget.
  RemittancesRecord? remittanceForRooms;
  // Stores action output result for [Backend Call - Read Document] action in roomsCard widget.
  TransactionsRecord? transactionFromRemittanceRooms;
  // Stores action output result for [Firestore Query - Query a collection] action in roomsCard widget.
  List<TransactionsRecord>? roomSales;
  // Stores action output result for [Firestore Query - Query a collection] action in expensesCard widget.
  RemittancesRecord? remittanceForExpenses;
  // Stores action output result for [Backend Call - Read Document] action in expensesCard widget.
  TransactionsRecord? transactionFromRemittanceExpenses;
  // Stores action output result for [Firestore Query - Query a collection] action in expensesCard widget.
  List<TransactionsRecord>? expensesRecalculate;
  // Stores action output result for [Firestore Query - Query a collection] action in billsCard widget.
  List<BillsRecord>? billsThisMonth;
  // Stores action output result for [Firestore Query - Query a collection] action in goodsCard widget.
  RemittancesRecord? remittanceForGoods;
  // Stores action output result for [Backend Call - Read Document] action in goodsCard widget.
  TransactionsRecord? transactionFromRemittanceGoods;
  // Stores action output result for [Firestore Query - Query a collection] action in goodsCard widget.
  List<TransactionsRecord>? goodSales;
  // Stores action output result for [Bottom Sheet - SalaryEdit] action in salariesCard widget.
  bool? salaryEdited;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  StatsRecord? statO;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  List<RoomsRecord>? roomsCheck;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks.
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
    if (initStatsCount > 0) {
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
              isEqualTo: functions.previousYear(month, year!),
            ),
      );
      // initialize all stats
      stats = foundMonthDoc.toList().cast<StatsRecord>();
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
      while (foundPrevMonthDoc.length != loopCounter) {
        // create hotel Metric
        addToPrevMetrics(MetricsHolderStruct(
          hotel: foundPrevMonthDoc[loopCounter].hotel,
          rooms: valueOrDefault<double>(
            foundPrevMonthDoc[loopCounter].roomsIncome,
            0.0,
          ),
          goods: valueOrDefault<double>(
            foundPrevMonthDoc[loopCounter].goodsIncome,
            0.0,
          ),
          expenses: valueOrDefault<double>(
            foundPrevMonthDoc[loopCounter].expenses,
            0.0,
          ),
          salaries: valueOrDefault<double>(
            foundPrevMonthDoc[loopCounter].salaries,
            0.0,
          ),
          bills: valueOrDefault<double>(
            foundPrevMonthDoc[loopCounter].bills,
            0.0,
          ),
          net: valueOrDefault<double>(
            foundPrevMonthDoc[loopCounter].roomsIncome +
                foundPrevMonthDoc[loopCounter].goodsIncome -
                foundPrevMonthDoc[loopCounter].expenses -
                foundPrevMonthDoc[loopCounter].salaries -
                foundPrevMonthDoc[loopCounter].bills,
            0.0,
          ),
        ));
        // increment loop
        loopCounter = loopCounter + 1;
      }
    } else {
      // initialize all page vars
      month = month!;
      year = year!;
      expenses = 0.0;
      salaries = 0.0;
      rooms = 0.0;
      goods = 0.0;
      hotel = 'All';
      bills = 0.0;
      net = 0.0;
      stats = [];
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
      hotel = hotel;
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
      // update net

      await stat!.reference.update(createStatsRecordData(
        net: stat!.roomsIncome +
            stat!.goodsIncome -
            stat!.salaries -
            stat!.expenses -
            stat!.bills -
            stat!.groceryExpenses,
      ));
    }

    return hotel;
  }
}
