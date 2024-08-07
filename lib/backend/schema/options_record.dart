import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OptionsRecord extends FirestoreRecord {
  OptionsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "choice" field.
  String? _choice;
  String get choice => _choice ?? '';
  bool hasChoice() => _choice != null;

  void _initializeFields() {
    _type = snapshotData['type'] as String?;
    _choice = snapshotData['choice'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('options');

  static Stream<OptionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => OptionsRecord.fromSnapshot(s));

  static Future<OptionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => OptionsRecord.fromSnapshot(s));

  static OptionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      OptionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static OptionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      OptionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'OptionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is OptionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createOptionsRecordData({
  String? type,
  String? choice,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'type': type,
      'choice': choice,
    }.withoutNulls,
  );

  return firestoreData;
}

class OptionsRecordDocumentEquality implements Equality<OptionsRecord> {
  const OptionsRecordDocumentEquality();

  @override
  bool equals(OptionsRecord? e1, OptionsRecord? e2) {
    return e1?.type == e2?.type && e1?.choice == e2?.choice;
  }

  @override
  int hash(OptionsRecord? e) => const ListEquality().hash([e?.type, e?.choice]);

  @override
  bool isValidKey(Object? o) => o is OptionsRecord;
}
