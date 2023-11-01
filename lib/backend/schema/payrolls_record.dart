import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PayrollsRecord extends FirestoreRecord {
  PayrollsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "total" field.
  double? _total;
  double get total => _total ?? 0.0;
  bool hasTotal() => _total != null;

  // "hotel" field.
  String? _hotel;
  String get hotel => _hotel ?? '';
  bool hasHotel() => _hotel != null;

  // "approvedBy" field.
  DocumentReference? _approvedBy;
  DocumentReference? get approvedBy => _approvedBy;
  bool hasApprovedBy() => _approvedBy != null;

  // "fortnight" field.
  String? _fortnight;
  String get fortnight => _fortnight ?? '';
  bool hasFortnight() => _fortnight != null;

  void _initializeFields() {
    _date = snapshotData['date'] as DateTime?;
    _status = snapshotData['status'] as String?;
    _total = castToType<double>(snapshotData['total']);
    _hotel = snapshotData['hotel'] as String?;
    _approvedBy = snapshotData['approvedBy'] as DocumentReference?;
    _fortnight = snapshotData['fortnight'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('payrolls');

  static Stream<PayrollsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PayrollsRecord.fromSnapshot(s));

  static Future<PayrollsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PayrollsRecord.fromSnapshot(s));

  static PayrollsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PayrollsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PayrollsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PayrollsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PayrollsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PayrollsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPayrollsRecordData({
  DateTime? date,
  String? status,
  double? total,
  String? hotel,
  DocumentReference? approvedBy,
  String? fortnight,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'date': date,
      'status': status,
      'total': total,
      'hotel': hotel,
      'approvedBy': approvedBy,
      'fortnight': fortnight,
    }.withoutNulls,
  );

  return firestoreData;
}

class PayrollsRecordDocumentEquality implements Equality<PayrollsRecord> {
  const PayrollsRecordDocumentEquality();

  @override
  bool equals(PayrollsRecord? e1, PayrollsRecord? e2) {
    return e1?.date == e2?.date &&
        e1?.status == e2?.status &&
        e1?.total == e2?.total &&
        e1?.hotel == e2?.hotel &&
        e1?.approvedBy == e2?.approvedBy &&
        e1?.fortnight == e2?.fortnight;
  }

  @override
  int hash(PayrollsRecord? e) => const ListEquality().hash(
      [e?.date, e?.status, e?.total, e?.hotel, e?.approvedBy, e?.fortnight]);

  @override
  bool isValidKey(Object? o) => o is PayrollsRecord;
}
