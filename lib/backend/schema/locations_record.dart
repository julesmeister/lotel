import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LocationsRecord extends FirestoreRecord {
  LocationsRecord._(
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

  // "withCR" field.
  bool? _withCR;
  bool get withCR => _withCR ?? false;
  bool hasWithCR() => _withCR != null;

  // "hotel" field.
  String? _hotel;
  String get hotel => _hotel ?? '';
  bool hasHotel() => _hotel != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  void _initializeFields() {
    _replacements = getDataList(snapshotData['replacements']);
    _sockets = castToType<int>(snapshotData['sockets']);
    _withCR = snapshotData['withCR'] as bool?;
    _hotel = snapshotData['hotel'] as String?;
    _description = snapshotData['description'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('locations');

  static Stream<LocationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => LocationsRecord.fromSnapshot(s));

  static Future<LocationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => LocationsRecord.fromSnapshot(s));

  static LocationsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      LocationsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static LocationsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      LocationsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'LocationsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is LocationsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createLocationsRecordData({
  int? sockets,
  bool? withCR,
  String? hotel,
  String? description,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'sockets': sockets,
      'withCR': withCR,
      'hotel': hotel,
      'description': description,
    }.withoutNulls,
  );

  return firestoreData;
}

class LocationsRecordDocumentEquality implements Equality<LocationsRecord> {
  const LocationsRecordDocumentEquality();

  @override
  bool equals(LocationsRecord? e1, LocationsRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.replacements, e2?.replacements) &&
        e1?.sockets == e2?.sockets &&
        e1?.withCR == e2?.withCR &&
        e1?.hotel == e2?.hotel &&
        e1?.description == e2?.description;
  }

  @override
  int hash(LocationsRecord? e) => const ListEquality()
      .hash([e?.replacements, e?.sockets, e?.withCR, e?.hotel, e?.description]);

  @override
  bool isValidKey(Object? o) => o is LocationsRecord;
}
