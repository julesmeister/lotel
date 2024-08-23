import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ReplacementRecord extends FirestoreRecord {
  ReplacementRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "requestedBy" field.
  String? _requestedBy;
  String get requestedBy => _requestedBy ?? '';
  bool hasRequestedBy() => _requestedBy != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "watts" field.
  int? _watts;
  int get watts => _watts ?? 0;
  bool hasWatts() => _watts != null;

  // "quantity" field.
  int? _quantity;
  int get quantity => _quantity ?? 0;
  bool hasQuantity() => _quantity != null;

  // "hotel" field.
  String? _hotel;
  String get hotel => _hotel ?? '';
  bool hasHotel() => _hotel != null;

  // "location" field.
  DocumentReference? _location;
  DocumentReference? get location => _location;
  bool hasLocation() => _location != null;

  // "cr" field.
  DocumentReference? _cr;
  DocumentReference? get cr => _cr;
  bool hasCr() => _cr != null;

  void _initializeFields() {
    _requestedBy = snapshotData['requestedBy'] as String?;
    _date = snapshotData['date'] as DateTime?;
    _watts = castToType<int>(snapshotData['watts']);
    _quantity = castToType<int>(snapshotData['quantity']);
    _hotel = snapshotData['hotel'] as String?;
    _location = snapshotData['location'] as DocumentReference?;
    _cr = snapshotData['cr'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('replacement');

  static Stream<ReplacementRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ReplacementRecord.fromSnapshot(s));

  static Future<ReplacementRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ReplacementRecord.fromSnapshot(s));

  static ReplacementRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ReplacementRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ReplacementRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ReplacementRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ReplacementRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ReplacementRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createReplacementRecordData({
  String? requestedBy,
  DateTime? date,
  int? watts,
  int? quantity,
  String? hotel,
  DocumentReference? location,
  DocumentReference? cr,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'requestedBy': requestedBy,
      'date': date,
      'watts': watts,
      'quantity': quantity,
      'hotel': hotel,
      'location': location,
      'cr': cr,
    }.withoutNulls,
  );

  return firestoreData;
}

class ReplacementRecordDocumentEquality implements Equality<ReplacementRecord> {
  const ReplacementRecordDocumentEquality();

  @override
  bool equals(ReplacementRecord? e1, ReplacementRecord? e2) {
    return e1?.requestedBy == e2?.requestedBy &&
        e1?.date == e2?.date &&
        e1?.watts == e2?.watts &&
        e1?.quantity == e2?.quantity &&
        e1?.hotel == e2?.hotel &&
        e1?.location == e2?.location &&
        e1?.cr == e2?.cr;
  }

  @override
  int hash(ReplacementRecord? e) => const ListEquality().hash([
        e?.requestedBy,
        e?.date,
        e?.watts,
        e?.quantity,
        e?.hotel,
        e?.location,
        e?.cr
      ]);

  @override
  bool isValidKey(Object? o) => o is ReplacementRecord;
}
