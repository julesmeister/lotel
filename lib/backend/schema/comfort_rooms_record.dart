import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ComfortRoomsRecord extends FirestoreRecord {
  ComfortRoomsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "sockets" field.
  int? _sockets;
  int get sockets => _sockets ?? 0;
  bool hasSockets() => _sockets != null;

  // "hotel" field.
  String? _hotel;
  String get hotel => _hotel ?? '';
  bool hasHotel() => _hotel != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  void _initializeFields() {
    _sockets = castToType<int>(snapshotData['sockets']);
    _hotel = snapshotData['hotel'] as String?;
    _description = snapshotData['description'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('comfortRooms');

  static Stream<ComfortRoomsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ComfortRoomsRecord.fromSnapshot(s));

  static Future<ComfortRoomsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ComfortRoomsRecord.fromSnapshot(s));

  static ComfortRoomsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ComfortRoomsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ComfortRoomsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ComfortRoomsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ComfortRoomsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ComfortRoomsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createComfortRoomsRecordData({
  int? sockets,
  String? hotel,
  String? description,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'sockets': sockets,
      'hotel': hotel,
      'description': description,
    }.withoutNulls,
  );

  return firestoreData;
}

class ComfortRoomsRecordDocumentEquality
    implements Equality<ComfortRoomsRecord> {
  const ComfortRoomsRecordDocumentEquality();

  @override
  bool equals(ComfortRoomsRecord? e1, ComfortRoomsRecord? e2) {
    return e1?.sockets == e2?.sockets &&
        e1?.hotel == e2?.hotel &&
        e1?.description == e2?.description;
  }

  @override
  int hash(ComfortRoomsRecord? e) =>
      const ListEquality().hash([e?.sockets, e?.hotel, e?.description]);

  @override
  bool isValidKey(Object? o) => o is ComfortRoomsRecord;
}
