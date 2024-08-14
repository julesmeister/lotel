import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CrRecord extends FirestoreRecord {
  CrRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "replacements" field.
  List<DocumentReference>? _replacements;
  List<DocumentReference> get replacements => _replacements ?? const [];
  bool hasReplacements() => _replacements != null;

  // "sockets" field.
  int? _sockets;
  int get sockets => _sockets ?? 0;
  bool hasSockets() => _sockets != null;

  // "hotel" field.
  String? _hotel;
  String get hotel => _hotel ?? '';
  bool hasHotel() => _hotel != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _replacements = getDataList(snapshotData['replacements']);
    _sockets = castToType<int>(snapshotData['sockets']);
    _hotel = snapshotData['hotel'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('cr')
          : FirebaseFirestore.instance.collectionGroup('cr');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('cr').doc(id);

  static Stream<CrRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CrRecord.fromSnapshot(s));

  static Future<CrRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CrRecord.fromSnapshot(s));

  static CrRecord fromSnapshot(DocumentSnapshot snapshot) => CrRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CrRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CrRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CrRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CrRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCrRecordData({
  int? sockets,
  String? hotel,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'sockets': sockets,
      'hotel': hotel,
    }.withoutNulls,
  );

  return firestoreData;
}

class CrRecordDocumentEquality implements Equality<CrRecord> {
  const CrRecordDocumentEquality();

  @override
  bool equals(CrRecord? e1, CrRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.replacements, e2?.replacements) &&
        e1?.sockets == e2?.sockets &&
        e1?.hotel == e2?.hotel;
  }

  @override
  int hash(CrRecord? e) =>
      const ListEquality().hash([e?.replacements, e?.sockets, e?.hotel]);

  @override
  bool isValidKey(Object? o) => o is CrRecord;
}
