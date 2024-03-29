import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RoomsRecord extends FirestoreRecord {
  RoomsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "number" field.
  int? _number;
  int get number => _number ?? 0;
  bool hasNumber() => _number != null;

  // "capacity" field.
  int? _capacity;
  int get capacity => _capacity ?? 0;
  bool hasCapacity() => _capacity != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "vacant" field.
  bool? _vacant;
  bool get vacant => _vacant ?? false;
  bool hasVacant() => _vacant != null;

  // "guests" field.
  int? _guests;
  int get guests => _guests ?? 0;
  bool hasGuests() => _guests != null;

  // "hotel" field.
  String? _hotel;
  String get hotel => _hotel ?? '';
  bool hasHotel() => _hotel != null;

  // "currentBooking" field.
  DocumentReference? _currentBooking;
  DocumentReference? get currentBooking => _currentBooking;
  bool hasCurrentBooking() => _currentBooking != null;

  void _initializeFields() {
    _number = castToType<int>(snapshotData['number']);
    _capacity = castToType<int>(snapshotData['capacity']);
    _price = castToType<double>(snapshotData['price']);
    _vacant = snapshotData['vacant'] as bool?;
    _guests = castToType<int>(snapshotData['guests']);
    _hotel = snapshotData['hotel'] as String?;
    _currentBooking = snapshotData['currentBooking'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('rooms');

  static Stream<RoomsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RoomsRecord.fromSnapshot(s));

  static Future<RoomsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RoomsRecord.fromSnapshot(s));

  static RoomsRecord fromSnapshot(DocumentSnapshot snapshot) => RoomsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RoomsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RoomsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RoomsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RoomsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRoomsRecordData({
  int? number,
  int? capacity,
  double? price,
  bool? vacant,
  int? guests,
  String? hotel,
  DocumentReference? currentBooking,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'number': number,
      'capacity': capacity,
      'price': price,
      'vacant': vacant,
      'guests': guests,
      'hotel': hotel,
      'currentBooking': currentBooking,
    }.withoutNulls,
  );

  return firestoreData;
}

class RoomsRecordDocumentEquality implements Equality<RoomsRecord> {
  const RoomsRecordDocumentEquality();

  @override
  bool equals(RoomsRecord? e1, RoomsRecord? e2) {
    return e1?.number == e2?.number &&
        e1?.capacity == e2?.capacity &&
        e1?.price == e2?.price &&
        e1?.vacant == e2?.vacant &&
        e1?.guests == e2?.guests &&
        e1?.hotel == e2?.hotel &&
        e1?.currentBooking == e2?.currentBooking;
  }

  @override
  int hash(RoomsRecord? e) => const ListEquality().hash([
        e?.number,
        e?.capacity,
        e?.price,
        e?.vacant,
        e?.guests,
        e?.hotel,
        e?.currentBooking
      ]);

  @override
  bool isValidKey(Object? o) => o is RoomsRecord;
}
