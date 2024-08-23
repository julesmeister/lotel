import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AbsencesRecord extends FirestoreRecord {
  AbsencesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "settled" field.
  bool? _settled;
  bool get settled => _settled ?? false;
  bool hasSettled() => _settled != null;

  // "amount" field.
  double? _amount;
  double get amount => _amount ?? 0.0;
  bool hasAmount() => _amount != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "encodedBy" field.
  DocumentReference? _encodedBy;
  DocumentReference? get encodedBy => _encodedBy;
  bool hasEncodedBy() => _encodedBy != null;

  // "remitted" field.
  bool? _remitted;
  bool get remitted => _remitted ?? false;
  bool hasRemitted() => _remitted != null;

  // "hotel" field.
  String? _hotel;
  String get hotel => _hotel ?? '';
  bool hasHotel() => _hotel != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _settled = snapshotData['settled'] as bool?;
    _amount = castToType<double>(snapshotData['amount']);
    _date = snapshotData['date'] as DateTime?;
    _encodedBy = snapshotData['encodedBy'] as DocumentReference?;
    _remitted = snapshotData['remitted'] as bool?;
    _hotel = snapshotData['hotel'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('absences')
          : FirebaseFirestore.instance.collectionGroup('absences');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('absences').doc(id);

  static Stream<AbsencesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AbsencesRecord.fromSnapshot(s));

  static Future<AbsencesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AbsencesRecord.fromSnapshot(s));

  static AbsencesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AbsencesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AbsencesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AbsencesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AbsencesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AbsencesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAbsencesRecordData({
  bool? settled,
  double? amount,
  DateTime? date,
  DocumentReference? encodedBy,
  bool? remitted,
  String? hotel,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'settled': settled,
      'amount': amount,
      'date': date,
      'encodedBy': encodedBy,
      'remitted': remitted,
      'hotel': hotel,
    }.withoutNulls,
  );

  return firestoreData;
}

class AbsencesRecordDocumentEquality implements Equality<AbsencesRecord> {
  const AbsencesRecordDocumentEquality();

  @override
  bool equals(AbsencesRecord? e1, AbsencesRecord? e2) {
    return e1?.settled == e2?.settled &&
        e1?.amount == e2?.amount &&
        e1?.date == e2?.date &&
        e1?.encodedBy == e2?.encodedBy &&
        e1?.remitted == e2?.remitted &&
        e1?.hotel == e2?.hotel;
  }

  @override
  int hash(AbsencesRecord? e) => const ListEquality().hash(
      [e?.settled, e?.amount, e?.date, e?.encodedBy, e?.remitted, e?.hotel]);

  @override
  bool isValidKey(Object? o) => o is AbsencesRecord;
}
