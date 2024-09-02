import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RecordsRecord extends FirestoreRecord {
  RecordsRecord._(
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

  // "hotel" field.
  String? _hotel;
  String get hotel => _hotel ?? '';
  bool hasHotel() => _hotel != null;

  // "receivedBy" field.
  String? _receivedBy;
  String get receivedBy => _receivedBy ?? '';
  bool hasReceivedBy() => _receivedBy != null;

  // "issuedBy" field.
  String? _issuedBy;
  String get issuedBy => _issuedBy ?? '';
  bool hasIssuedBy() => _issuedBy != null;

  void _initializeFields() {
    _date = snapshotData['date'] as DateTime?;
    _detail = snapshotData['detail'] as String?;
    _hotel = snapshotData['hotel'] as String?;
    _receivedBy = snapshotData['receivedBy'] as String?;
    _issuedBy = snapshotData['issuedBy'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('records');

  static Stream<RecordsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RecordsRecord.fromSnapshot(s));

  static Future<RecordsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RecordsRecord.fromSnapshot(s));

  static RecordsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RecordsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RecordsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RecordsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RecordsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RecordsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRecordsRecordData({
  DateTime? date,
  String? detail,
  String? hotel,
  String? receivedBy,
  String? issuedBy,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'date': date,
      'detail': detail,
      'hotel': hotel,
      'receivedBy': receivedBy,
      'issuedBy': issuedBy,
    }.withoutNulls,
  );

  return firestoreData;
}

class RecordsRecordDocumentEquality implements Equality<RecordsRecord> {
  const RecordsRecordDocumentEquality();

  @override
  bool equals(RecordsRecord? e1, RecordsRecord? e2) {
    return e1?.date == e2?.date &&
        e1?.detail == e2?.detail &&
        e1?.hotel == e2?.hotel &&
        e1?.receivedBy == e2?.receivedBy &&
        e1?.issuedBy == e2?.issuedBy;
  }

  @override
  int hash(RecordsRecord? e) => const ListEquality()
      .hash([e?.date, e?.detail, e?.hotel, e?.receivedBy, e?.issuedBy]);

  @override
  bool isValidKey(Object? o) => o is RecordsRecord;
}
