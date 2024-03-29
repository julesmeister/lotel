import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AdvancesRecord extends FirestoreRecord {
  AdvancesRecord._(
    super.reference,
    super.data,
  ) {
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

  // "requestedBy" field.
  DocumentReference? _requestedBy;
  DocumentReference? get requestedBy => _requestedBy;
  bool hasRequestedBy() => _requestedBy != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _settled = snapshotData['settled'] as bool?;
    _amount = castToType<double>(snapshotData['amount']);
    _date = snapshotData['date'] as DateTime?;
    _requestedBy = snapshotData['requestedBy'] as DocumentReference?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('advances')
          : FirebaseFirestore.instance.collectionGroup('advances');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('advances').doc(id);

  static Stream<AdvancesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AdvancesRecord.fromSnapshot(s));

  static Future<AdvancesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AdvancesRecord.fromSnapshot(s));

  static AdvancesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AdvancesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AdvancesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AdvancesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AdvancesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AdvancesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAdvancesRecordData({
  bool? settled,
  double? amount,
  DateTime? date,
  DocumentReference? requestedBy,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'settled': settled,
      'amount': amount,
      'date': date,
      'requestedBy': requestedBy,
    }.withoutNulls,
  );

  return firestoreData;
}

class AdvancesRecordDocumentEquality implements Equality<AdvancesRecord> {
  const AdvancesRecordDocumentEquality();

  @override
  bool equals(AdvancesRecord? e1, AdvancesRecord? e2) {
    return e1?.settled == e2?.settled &&
        e1?.amount == e2?.amount &&
        e1?.date == e2?.date &&
        e1?.requestedBy == e2?.requestedBy;
  }

  @override
  int hash(AdvancesRecord? e) => const ListEquality()
      .hash([e?.settled, e?.amount, e?.date, e?.requestedBy]);

  @override
  bool isValidKey(Object? o) => o is AdvancesRecord;
}
