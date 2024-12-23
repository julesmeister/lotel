import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class IssuesRecord extends FirestoreRecord {
  IssuesRecord._(
    super.reference,
    super.data,
  ) {
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

  // "dateFixed" field.
  DateTime? _dateFixed;
  DateTime? get dateFixed => _dateFixed;
  bool hasDateFixed() => _dateFixed != null;

  // "staffName" field.
  String? _staffName;
  String get staffName => _staffName ?? '';
  bool hasStaffName() => _staffName != null;

  void _initializeFields() {
    _date = snapshotData['date'] as DateTime?;
    _detail = snapshotData['detail'] as String?;
    _status = snapshotData['status'] as String?;
    _hotel = snapshotData['hotel'] as String?;
    _dateFixed = snapshotData['dateFixed'] as DateTime?;
    _staffName = snapshotData['staffName'] as String?;
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
  DateTime? dateFixed,
  String? staffName,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'date': date,
      'detail': detail,
      'status': status,
      'hotel': hotel,
      'dateFixed': dateFixed,
      'staffName': staffName,
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
        e1?.dateFixed == e2?.dateFixed &&
        e1?.staffName == e2?.staffName;
  }

  @override
  int hash(IssuesRecord? e) => const ListEquality().hash(
      [e?.date, e?.detail, e?.status, e?.hotel, e?.dateFixed, e?.staffName]);

  @override
  bool isValidKey(Object? o) => o is IssuesRecord;
}
