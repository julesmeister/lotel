import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'metrics_yearly_widget.dart' show MetricsYearlyWidget;
import 'package:flutter/material.dart';

class MetricsYearlyModel extends FlutterFlowModel<MetricsYearlyWidget> {
  ///  Local state fields for this page.

  String year = '2024';

  List<YearlySalesStruct> goodsLine = [];
  void addToGoodsLine(YearlySalesStruct item) => goodsLine.add(item);
  void removeFromGoodsLine(YearlySalesStruct item) => goodsLine.remove(item);
  void removeAtIndexFromGoodsLine(int index) => goodsLine.removeAt(index);
  void insertAtIndexInGoodsLine(int index, YearlySalesStruct item) =>
      goodsLine.insert(index, item);
  void updateGoodsLineAtIndex(
          int index, Function(YearlySalesStruct) updateFn) =>
      goodsLine[index] = updateFn(goodsLine[index]);

  List<YearlySalesStruct> roomLine = [];
  void addToRoomLine(YearlySalesStruct item) => roomLine.add(item);
  void removeFromRoomLine(YearlySalesStruct item) => roomLine.remove(item);
  void removeAtIndexFromRoomLine(int index) => roomLine.removeAt(index);
  void insertAtIndexInRoomLine(int index, YearlySalesStruct item) =>
      roomLine.insert(index, item);
  void updateRoomLineAtIndex(int index, Function(YearlySalesStruct) updateFn) =>
      roomLine[index] = updateFn(roomLine[index]);

  DocumentReference? statsRef;

  String hotel = 'All';

  List<StatsRecord> stats = [];
  void addToStats(StatsRecord item) => stats.add(item);
  void removeFromStats(StatsRecord item) => stats.remove(item);
  void removeAtIndexFromStats(int index) => stats.removeAt(index);
  void insertAtIndexInStats(int index, StatsRecord item) =>
      stats.insert(index, item);
  void updateStatsAtIndex(int index, Function(StatsRecord) updateFn) =>
      stats[index] = updateFn(stats[index]);

  StatsRecord? stat;

  int loopCounter = 0;

  String category = 'Rooms';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
