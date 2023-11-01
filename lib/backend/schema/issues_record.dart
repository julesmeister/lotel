import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class IssuesRecord extends FirestoreRecord {
  IssuesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "detail" field.
  String? _detail;
  String get detail => _detail ?? '';
  bool hasDetail() => _detail != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "hotel" field.
  String? _hotel;
  String get hotel => _hotel ?? '';
  bool hasHotel() => _hotel != null;

  // "staff" field.
  DocumentReference? _staff;
  DocumentReference? get staff => _staff;
  bool hasStaff() => _staff != null;

  void _initializeFields() {
    _date = snapshotData['date'] as DateTime?;
    _detail = snapshotData['detail'] as String?;
    _status = snapshotData['status'] as String?;
    _hotel = snapshotData['hotel'] as String?;
    _staff = snapshotData['staff'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('issues');

  static Stream<IssuesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => IssuesRecord.fromSnapshot(s));

  static Future<IssuesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => IssuesRecord.fromSnapshot(s));

  static IssuesRecord fromSnapshot(DocumentSnapshot snapshot) => IssuesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static IssuesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      IssuesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'IssuesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is IssuesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createIssuesRecordData({
  DateTime? date,
  String? detail,
  String? status,
  String? hotel,
  DocumentReference? staff,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'date': date,
      'detail': detail,
      'status': status,
      'hotel': hotel,
      'staff': staff,
    }.withoutNulls,
  );

  return firestoreData;
}

class IssuesRecordDocumentEquality implements Equality<IssuesRecord> {
  const IssuesRecordDocumentEquality();

  @override
  bool equals(IssuesRecord? e1, IssuesRecord? e2) {
    return e1?.date == e2?.date &&
        e1?.detail == e2?.detail &&
        e1?.status == e2?.status &&
        e1?.hotel == e2?.hotel &&
        e1?.staff == e2?.staff;
  }

  @override
  int hash(IssuesRecord? e) => const ListEquality()
      .hash([e?.date, e?.detail, e?.status, e?.hotel, e?.staff]);

  @override
  bool isValidKey(Object? o) => o is IssuesRecord;
}
