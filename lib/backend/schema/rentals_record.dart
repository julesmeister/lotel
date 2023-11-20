import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RentalsRecord extends FirestoreRecord {
  RentalsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "hotel" field.
  String? _hotel;
  String get hotel => _hotel ?? '';
  bool hasHotel() => _hotel != null;

  // "total" field.
  double? _total;
  double get total => _total ?? 0.0;
  bool hasTotal() => _total != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "fortnight" field.
  String? _fortnight;
  String get fortnight => _fortnight ?? '';
  bool hasFortnight() => _fortnight != null;

  // "wTax" field.
  double? _wTax;
  double get wTax => _wTax ?? 0.0;
  bool hasWTax() => _wTax != null;

  void _initializeFields() {
    _date = snapshotData['date'] as DateTime?;
    _hotel = snapshotData['hotel'] as String?;
    _total = castToType<double>(snapshotData['total']);
    _status = snapshotData['status'] as String?;
    _fortnight = snapshotData['fortnight'] as String?;
    _wTax = castToType<double>(snapshotData['wTax']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('rentals');

  static Stream<RentalsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RentalsRecord.fromSnapshot(s));

  static Future<RentalsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RentalsRecord.fromSnapshot(s));

  static RentalsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RentalsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RentalsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RentalsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RentalsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RentalsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRentalsRecordData({
  DateTime? date,
  String? hotel,
  double? total,
  String? status,
  String? fortnight,
  double? wTax,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'date': date,
      'hotel': hotel,
      'total': total,
      'status': status,
      'fortnight': fortnight,
      'wTax': wTax,
    }.withoutNulls,
  );

  return firestoreData;
}

class RentalsRecordDocumentEquality implements Equality<RentalsRecord> {
  const RentalsRecordDocumentEquality();

  @override
  bool equals(RentalsRecord? e1, RentalsRecord? e2) {
    return e1?.date == e2?.date &&
        e1?.hotel == e2?.hotel &&
        e1?.total == e2?.total &&
        e1?.status == e2?.status &&
        e1?.fortnight == e2?.fortnight &&
        e1?.wTax == e2?.wTax;
  }

  @override
  int hash(RentalsRecord? e) => const ListEquality()
      .hash([e?.date, e?.hotel, e?.total, e?.status, e?.fortnight, e?.wTax]);

  @override
  bool isValidKey(Object? o) => o is RentalsRecord;
}
