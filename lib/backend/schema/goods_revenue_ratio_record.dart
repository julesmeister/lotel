import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GoodsRevenueRatioRecord extends FirestoreRecord {
  GoodsRevenueRatioRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "grocery" field.
  double? _grocery;
  double get grocery => _grocery ?? 0.0;
  bool hasGrocery() => _grocery != null;

  // "revenue" field.
  double? _revenue;
  double get revenue => _revenue ?? 0.0;
  bool hasRevenue() => _revenue != null;

  // "hotel" field.
  String? _hotel;
  String get hotel => _hotel ?? '';
  bool hasHotel() => _hotel != null;

  void _initializeFields() {
    _date = snapshotData['date'] as DateTime?;
    _grocery = castToType<double>(snapshotData['grocery']);
    _revenue = castToType<double>(snapshotData['revenue']);
    _hotel = snapshotData['hotel'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('goods_revenue_ratio');

  static Stream<GoodsRevenueRatioRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GoodsRevenueRatioRecord.fromSnapshot(s));

  static Future<GoodsRevenueRatioRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => GoodsRevenueRatioRecord.fromSnapshot(s));

  static GoodsRevenueRatioRecord fromSnapshot(DocumentSnapshot snapshot) =>
      GoodsRevenueRatioRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GoodsRevenueRatioRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GoodsRevenueRatioRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'GoodsRevenueRatioRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GoodsRevenueRatioRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGoodsRevenueRatioRecordData({
  DateTime? date,
  double? grocery,
  double? revenue,
  String? hotel,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'date': date,
      'grocery': grocery,
      'revenue': revenue,
      'hotel': hotel,
    }.withoutNulls,
  );

  return firestoreData;
}

class GoodsRevenueRatioRecordDocumentEquality
    implements Equality<GoodsRevenueRatioRecord> {
  const GoodsRevenueRatioRecordDocumentEquality();

  @override
  bool equals(GoodsRevenueRatioRecord? e1, GoodsRevenueRatioRecord? e2) {
    return e1?.date == e2?.date &&
        e1?.grocery == e2?.grocery &&
        e1?.revenue == e2?.revenue &&
        e1?.hotel == e2?.hotel;
  }

  @override
  int hash(GoodsRevenueRatioRecord? e) =>
      const ListEquality().hash([e?.date, e?.grocery, e?.revenue, e?.hotel]);

  @override
  bool isValidKey(Object? o) => o is GoodsRevenueRatioRecord;
}
