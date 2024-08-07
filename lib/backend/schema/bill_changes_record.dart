import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BillChangesRecord extends FirestoreRecord {
  BillChangesRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "staff" field.
  DocumentReference? _staff;
  DocumentReference? get staff => _staff;
  bool hasStaff() => _staff != null;

  // "hotel" field.
  String? _hotel;
  String get hotel => _hotel ?? '';
  bool hasHotel() => _hotel != null;

  void _initializeFields() {
    _date = snapshotData['date'] as DateTime?;
    _description = snapshotData['description'] as String?;
    _staff = snapshotData['staff'] as DocumentReference?;
    _hotel = snapshotData['hotel'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('billChanges');

  static Stream<BillChangesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => BillChangesRecord.fromSnapshot(s));

  static Future<BillChangesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => BillChangesRecord.fromSnapshot(s));

  static BillChangesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      BillChangesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static BillChangesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      BillChangesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'BillChangesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is BillChangesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createBillChangesRecordData({
  DateTime? date,
  String? description,
  DocumentReference? staff,
  String? hotel,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'date': date,
      'description': description,
      'staff': staff,
      'hotel': hotel,
    }.withoutNulls,
  );

  return firestoreData;
}

class BillChangesRecordDocumentEquality implements Equality<BillChangesRecord> {
  const BillChangesRecordDocumentEquality();

  @override
  bool equals(BillChangesRecord? e1, BillChangesRecord? e2) {
    return e1?.date == e2?.date &&
        e1?.description == e2?.description &&
        e1?.staff == e2?.staff &&
        e1?.hotel == e2?.hotel;
  }

  @override
  int hash(BillChangesRecord? e) =>
      const ListEquality().hash([e?.date, e?.description, e?.staff, e?.hotel]);

  @override
  bool isValidKey(Object? o) => o is BillChangesRecord;
}
