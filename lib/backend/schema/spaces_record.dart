import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SpacesRecord extends FirestoreRecord {
  SpacesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "unit" field.
  int? _unit;
  int get unit => _unit ?? 0;
  bool hasUnit() => _unit != null;

  // "owner" field.
  String? _owner;
  String get owner => _owner ?? '';
  bool hasOwner() => _owner != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "amount" field.
  double? _amount;
  double get amount => _amount ?? 0.0;
  bool hasAmount() => _amount != null;

  // "collected" field.
  bool? _collected;
  bool get collected => _collected ?? false;
  bool hasCollected() => _collected != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _unit = castToType<int>(snapshotData['unit']);
    _owner = snapshotData['owner'] as String?;
    _date = snapshotData['date'] as DateTime?;
    _amount = castToType<double>(snapshotData['amount']);
    _collected = snapshotData['collected'] as bool?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('spaces')
          : FirebaseFirestore.instance.collectionGroup('spaces');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('spaces').doc();

  static Stream<SpacesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SpacesRecord.fromSnapshot(s));

  static Future<SpacesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SpacesRecord.fromSnapshot(s));

  static SpacesRecord fromSnapshot(DocumentSnapshot snapshot) => SpacesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SpacesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SpacesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SpacesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SpacesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSpacesRecordData({
  int? unit,
  String? owner,
  DateTime? date,
  double? amount,
  bool? collected,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'unit': unit,
      'owner': owner,
      'date': date,
      'amount': amount,
      'collected': collected,
    }.withoutNulls,
  );

  return firestoreData;
}

class SpacesRecordDocumentEquality implements Equality<SpacesRecord> {
  const SpacesRecordDocumentEquality();

  @override
  bool equals(SpacesRecord? e1, SpacesRecord? e2) {
    return e1?.unit == e2?.unit &&
        e1?.owner == e2?.owner &&
        e1?.date == e2?.date &&
        e1?.amount == e2?.amount &&
        e1?.collected == e2?.collected;
  }

  @override
  int hash(SpacesRecord? e) => const ListEquality()
      .hash([e?.unit, e?.owner, e?.date, e?.amount, e?.collected]);

  @override
  bool isValidKey(Object? o) => o is SpacesRecord;
}
