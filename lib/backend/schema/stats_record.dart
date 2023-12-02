import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class StatsRecord extends FirestoreRecord {
  StatsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "hotel" field.
  String? _hotel;
  String get hotel => _hotel ?? '';
  bool hasHotel() => _hotel != null;

  // "year" field.
  String? _year;
  String get year => _year ?? '';
  bool hasYear() => _year != null;

  // "month" field.
  String? _month;
  String get month => _month ?? '';
  bool hasMonth() => _month != null;

  // "days" field.
  int? _days;
  int get days => _days ?? 0;
  bool hasDays() => _days != null;

  // "roomsIncome" field.
  double? _roomsIncome;
  double get roomsIncome => _roomsIncome ?? 0.0;
  bool hasRoomsIncome() => _roomsIncome != null;

  // "goodsIncome" field.
  double? _goodsIncome;
  double get goodsIncome => _goodsIncome ?? 0.0;
  bool hasGoodsIncome() => _goodsIncome != null;

  // "expenses" field.
  double? _expenses;
  double get expenses => _expenses ?? 0.0;
  bool hasExpenses() => _expenses != null;

  // "salaries" field.
  double? _salaries;
  double get salaries => _salaries ?? 0.0;
  bool hasSalaries() => _salaries != null;

  // "roomUsage" field.
  List<RoomUsageStruct>? _roomUsage;
  List<RoomUsageStruct> get roomUsage => _roomUsage ?? const [];
  bool hasRoomUsage() => _roomUsage != null;

  // "roomLine" field.
  LineGraphStruct? _roomLine;
  LineGraphStruct get roomLine => _roomLine ?? LineGraphStruct();
  bool hasRoomLine() => _roomLine != null;

  // "goodsLine" field.
  LineGraphStruct? _goodsLine;
  LineGraphStruct get goodsLine => _goodsLine ?? LineGraphStruct();
  bool hasGoodsLine() => _goodsLine != null;

  // "rentIncome" field.
  double? _rentIncome;
  double get rentIncome => _rentIncome ?? 0.0;
  bool hasRentIncome() => _rentIncome != null;

  // "groceryExpenses" field.
  double? _groceryExpenses;
  double get groceryExpenses => _groceryExpenses ?? 0.0;
  bool hasGroceryExpenses() => _groceryExpenses != null;

  void _initializeFields() {
    _hotel = snapshotData['hotel'] as String?;
    _year = snapshotData['year'] as String?;
    _month = snapshotData['month'] as String?;
    _days = castToType<int>(snapshotData['days']);
    _roomsIncome = castToType<double>(snapshotData['roomsIncome']);
    _goodsIncome = castToType<double>(snapshotData['goodsIncome']);
    _expenses = castToType<double>(snapshotData['expenses']);
    _salaries = castToType<double>(snapshotData['salaries']);
    _roomUsage = getStructList(
      snapshotData['roomUsage'],
      RoomUsageStruct.fromMap,
    );
    _roomLine = LineGraphStruct.maybeFromMap(snapshotData['roomLine']);
    _goodsLine = LineGraphStruct.maybeFromMap(snapshotData['goodsLine']);
    _rentIncome = castToType<double>(snapshotData['rentIncome']);
    _groceryExpenses = castToType<double>(snapshotData['groceryExpenses']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('stats');

  static Stream<StatsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => StatsRecord.fromSnapshot(s));

  static Future<StatsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => StatsRecord.fromSnapshot(s));

  static StatsRecord fromSnapshot(DocumentSnapshot snapshot) => StatsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static StatsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      StatsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'StatsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is StatsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createStatsRecordData({
  String? hotel,
  String? year,
  String? month,
  int? days,
  double? roomsIncome,
  double? goodsIncome,
  double? expenses,
  double? salaries,
  LineGraphStruct? roomLine,
  LineGraphStruct? goodsLine,
  double? rentIncome,
  double? groceryExpenses,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'hotel': hotel,
      'year': year,
      'month': month,
      'days': days,
      'roomsIncome': roomsIncome,
      'goodsIncome': goodsIncome,
      'expenses': expenses,
      'salaries': salaries,
      'roomLine': LineGraphStruct().toMap(),
      'goodsLine': LineGraphStruct().toMap(),
      'rentIncome': rentIncome,
      'groceryExpenses': groceryExpenses,
    }.withoutNulls,
  );

  // Handle nested data for "roomLine" field.
  addLineGraphStructData(firestoreData, roomLine, 'roomLine');

  // Handle nested data for "goodsLine" field.
  addLineGraphStructData(firestoreData, goodsLine, 'goodsLine');

  return firestoreData;
}

class StatsRecordDocumentEquality implements Equality<StatsRecord> {
  const StatsRecordDocumentEquality();

  @override
  bool equals(StatsRecord? e1, StatsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.hotel == e2?.hotel &&
        e1?.year == e2?.year &&
        e1?.month == e2?.month &&
        e1?.days == e2?.days &&
        e1?.roomsIncome == e2?.roomsIncome &&
        e1?.goodsIncome == e2?.goodsIncome &&
        e1?.expenses == e2?.expenses &&
        e1?.salaries == e2?.salaries &&
        listEquality.equals(e1?.roomUsage, e2?.roomUsage) &&
        e1?.roomLine == e2?.roomLine &&
        e1?.goodsLine == e2?.goodsLine &&
        e1?.rentIncome == e2?.rentIncome &&
        e1?.groceryExpenses == e2?.groceryExpenses;
  }

  @override
  int hash(StatsRecord? e) => const ListEquality().hash([
        e?.hotel,
        e?.year,
        e?.month,
        e?.days,
        e?.roomsIncome,
        e?.goodsIncome,
        e?.expenses,
        e?.salaries,
        e?.roomUsage,
        e?.roomLine,
        e?.goodsLine,
        e?.rentIncome,
        e?.groceryExpenses
      ]);

  @override
  bool isValidKey(Object? o) => o is StatsRecord;
}
