import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PurgedRecord extends FirestoreRecord {
  PurgedRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "start" field.
  DateTime? _start;
  DateTime? get start => _start;
  bool hasStart() => _start != null;

  // "end" field.
  DateTime? _end;
  DateTime? get end => _end;
  bool hasEnd() => _end != null;

  // "records" field.
  int? _records;
  int get records => _records ?? 0;
  bool hasRecords() => _records != null;

  // "authorized" field.
  String? _authorized;
  String get authorized => _authorized ?? '';
  bool hasAuthorized() => _authorized != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "hotel" field.
  String? _hotel;
  String get hotel => _hotel ?? '';
  bool hasHotel() => _hotel != null;

  void _initializeFields() {
    _start = snapshotData['start'] as DateTime?;
    _end = snapshotData['end'] as DateTime?;
    _records = castToType<int>(snapshotData['records']);
    _authorized = snapshotData['authorized'] as String?;
    _date = snapshotData['date'] as DateTime?;
    _hotel = snapshotData['hotel'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('purged');

  static Stream<PurgedRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PurgedRecord.fromSnapshot(s));

  static Future<PurgedRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PurgedRecord.fromSnapshot(s));

  static PurgedRecord fromSnapshot(DocumentSnapshot snapshot) => PurgedRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PurgedRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PurgedRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PurgedRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PurgedRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPurgedRecordData({
  DateTime? start,
  DateTime? end,
  int? records,
  String? authorized,
  DateTime? date,
  String? hotel,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'start': start,
      'end': end,
      'records': records,
      'authorized': authorized,
      'date': date,
      'hotel': hotel,
    }.withoutNulls,
  );

  return firestoreData;
}

class PurgedRecordDocumentEquality implements Equality<PurgedRecord> {
  const PurgedRecordDocumentEquality();

  @override
  bool equals(PurgedRecord? e1, PurgedRecord? e2) {
    return e1?.start == e2?.start &&
        e1?.end == e2?.end &&
        e1?.records == e2?.records &&
        e1?.authorized == e2?.authorized &&
        e1?.date == e2?.date &&
        e1?.hotel == e2?.hotel;
  }

  @override
  int hash(PurgedRecord? e) => const ListEquality()
      .hash([e?.start, e?.end, e?.records, e?.authorized, e?.date, e?.hotel]);

  @override
  bool isValidKey(Object? o) => o is PurgedRecord;
}
