import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class StaffsRecord extends FirestoreRecord {
  StaffsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "weeklyRate" field.
  double? _weeklyRate;
  double get weeklyRate => _weeklyRate ?? 0.0;
  bool hasWeeklyRate() => _weeklyRate != null;

  // "balance" field.
  double? _balance;
  double get balance => _balance ?? 0.0;
  bool hasBalance() => _balance != null;

  // "sssRate" field.
  double? _sssRate;
  double get sssRate => _sssRate ?? 0.0;
  bool hasSssRate() => _sssRate != null;

  // "hotel" field.
  String? _hotel;
  String get hotel => _hotel ?? '';
  bool hasHotel() => _hotel != null;

  // "fired" field.
  bool? _fired;
  bool get fired => _fired ?? false;
  bool hasFired() => _fired != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _weeklyRate = castToType<double>(snapshotData['weeklyRate']);
    _balance = castToType<double>(snapshotData['balance']);
    _sssRate = castToType<double>(snapshotData['sssRate']);
    _hotel = snapshotData['hotel'] as String?;
    _fired = snapshotData['fired'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('staffs');

  static Stream<StaffsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => StaffsRecord.fromSnapshot(s));

  static Future<StaffsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => StaffsRecord.fromSnapshot(s));

  static StaffsRecord fromSnapshot(DocumentSnapshot snapshot) => StaffsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static StaffsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      StaffsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'StaffsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is StaffsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createStaffsRecordData({
  String? name,
  double? weeklyRate,
  double? balance,
  double? sssRate,
  String? hotel,
  bool? fired,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'weeklyRate': weeklyRate,
      'balance': balance,
      'sssRate': sssRate,
      'hotel': hotel,
      'fired': fired,
    }.withoutNulls,
  );

  return firestoreData;
}

class StaffsRecordDocumentEquality implements Equality<StaffsRecord> {
  const StaffsRecordDocumentEquality();

  @override
  bool equals(StaffsRecord? e1, StaffsRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.weeklyRate == e2?.weeklyRate &&
        e1?.balance == e2?.balance &&
        e1?.sssRate == e2?.sssRate &&
        e1?.hotel == e2?.hotel &&
        e1?.fired == e2?.fired;
  }

  @override
  int hash(StaffsRecord? e) => const ListEquality().hash(
      [e?.name, e?.weeklyRate, e?.balance, e?.sssRate, e?.hotel, e?.fired]);

  @override
  bool isValidKey(Object? o) => o is StaffsRecord;
}
