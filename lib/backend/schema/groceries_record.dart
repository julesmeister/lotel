import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GroceriesRecord extends FirestoreRecord {
  GroceriesRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "hotel" field.
  String? _hotel;
  String get hotel => _hotel ?? '';
  bool hasHotel() => _hotel != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "recordedBy" field.
  DocumentReference? _recordedBy;
  DocumentReference? get recordedBy => _recordedBy;
  bool hasRecordedBy() => _recordedBy != null;

  // "amount" field.
  double? _amount;
  double get amount => _amount ?? 0.0;
  bool hasAmount() => _amount != null;

  // "remark" field.
  String? _remark;
  String get remark => _remark ?? '';
  bool hasRemark() => _remark != null;

  void _initializeFields() {
    _hotel = snapshotData['hotel'] as String?;
    _date = snapshotData['date'] as DateTime?;
    _recordedBy = snapshotData['recordedBy'] as DocumentReference?;
    _amount = castToType<double>(snapshotData['amount']);
    _remark = snapshotData['remark'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('groceries');

  static Stream<GroceriesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GroceriesRecord.fromSnapshot(s));

  static Future<GroceriesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GroceriesRecord.fromSnapshot(s));

  static GroceriesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      GroceriesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GroceriesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GroceriesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'GroceriesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GroceriesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGroceriesRecordData({
  String? hotel,
  DateTime? date,
  DocumentReference? recordedBy,
  double? amount,
  String? remark,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'hotel': hotel,
      'date': date,
      'recordedBy': recordedBy,
      'amount': amount,
      'remark': remark,
    }.withoutNulls,
  );

  return firestoreData;
}

class GroceriesRecordDocumentEquality implements Equality<GroceriesRecord> {
  const GroceriesRecordDocumentEquality();

  @override
  bool equals(GroceriesRecord? e1, GroceriesRecord? e2) {
    return e1?.hotel == e2?.hotel &&
        e1?.date == e2?.date &&
        e1?.recordedBy == e2?.recordedBy &&
        e1?.amount == e2?.amount &&
        e1?.remark == e2?.remark;
  }

  @override
  int hash(GroceriesRecord? e) => const ListEquality()
      .hash([e?.hotel, e?.date, e?.recordedBy, e?.amount, e?.remark]);

  @override
  bool isValidKey(Object? o) => o is GroceriesRecord;
}
