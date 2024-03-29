import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BillsRecord extends FirestoreRecord {
  BillsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "amount" field.
  double? _amount;
  double get amount => _amount ?? 0.0;
  bool hasAmount() => _amount != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "hotel" field.
  String? _hotel;
  String get hotel => _hotel ?? '';
  bool hasHotel() => _hotel != null;

  // "staff" field.
  DocumentReference? _staff;
  DocumentReference? get staff => _staff;
  bool hasStaff() => _staff != null;

  // "afterDue" field.
  double? _afterDue;
  double get afterDue => _afterDue ?? 0.0;
  bool hasAfterDue() => _afterDue != null;

  void _initializeFields() {
    _description = snapshotData['description'] as String?;
    _amount = castToType<double>(snapshotData['amount']);
    _date = snapshotData['date'] as DateTime?;
    _hotel = snapshotData['hotel'] as String?;
    _staff = snapshotData['staff'] as DocumentReference?;
    _afterDue = castToType<double>(snapshotData['afterDue']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('bills');

  static Stream<BillsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => BillsRecord.fromSnapshot(s));

  static Future<BillsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => BillsRecord.fromSnapshot(s));

  static BillsRecord fromSnapshot(DocumentSnapshot snapshot) => BillsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static BillsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      BillsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'BillsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is BillsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createBillsRecordData({
  String? description,
  double? amount,
  DateTime? date,
  String? hotel,
  DocumentReference? staff,
  double? afterDue,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'description': description,
      'amount': amount,
      'date': date,
      'hotel': hotel,
      'staff': staff,
      'afterDue': afterDue,
    }.withoutNulls,
  );

  return firestoreData;
}

class BillsRecordDocumentEquality implements Equality<BillsRecord> {
  const BillsRecordDocumentEquality();

  @override
  bool equals(BillsRecord? e1, BillsRecord? e2) {
    return e1?.description == e2?.description &&
        e1?.amount == e2?.amount &&
        e1?.date == e2?.date &&
        e1?.hotel == e2?.hotel &&
        e1?.staff == e2?.staff &&
        e1?.afterDue == e2?.afterDue;
  }

  @override
  int hash(BillsRecord? e) => const ListEquality().hash(
      [e?.description, e?.amount, e?.date, e?.hotel, e?.staff, e?.afterDue]);

  @override
  bool isValidKey(Object? o) => o is BillsRecord;
}
