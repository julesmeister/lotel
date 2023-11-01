import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TransactionsRecord extends FirestoreRecord {
  TransactionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "staff" field.
  DocumentReference? _staff;
  DocumentReference? get staff => _staff;
  bool hasStaff() => _staff != null;

  // "total" field.
  double? _total;
  double get total => _total ?? 0.0;
  bool hasTotal() => _total != null;

  // "goods" field.
  List<CartGoodsStruct>? _goods;
  List<CartGoodsStruct> get goods => _goods ?? const [];
  bool hasGoods() => _goods != null;

  // "hotel" field.
  String? _hotel;
  String get hotel => _hotel ?? '';
  bool hasHotel() => _hotel != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "booking" field.
  DocumentReference? _booking;
  DocumentReference? get booking => _booking;
  bool hasBooking() => _booking != null;

  // "guests" field.
  int? _guests;
  int get guests => _guests ?? 0;
  bool hasGuests() => _guests != null;

  // "room" field.
  int? _room;
  int get room => _room ?? 0;
  bool hasRoom() => _room != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "remitted" field.
  bool? _remitted;
  bool get remitted => _remitted ?? false;
  bool hasRemitted() => _remitted != null;

  void _initializeFields() {
    _date = snapshotData['date'] as DateTime?;
    _staff = snapshotData['staff'] as DocumentReference?;
    _total = castToType<double>(snapshotData['total']);
    _goods = getStructList(
      snapshotData['goods'],
      CartGoodsStruct.fromMap,
    );
    _hotel = snapshotData['hotel'] as String?;
    _type = snapshotData['type'] as String?;
    _booking = snapshotData['booking'] as DocumentReference?;
    _guests = castToType<int>(snapshotData['guests']);
    _room = castToType<int>(snapshotData['room']);
    _description = snapshotData['description'] as String?;
    _remitted = snapshotData['remitted'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('transactions');

  static Stream<TransactionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TransactionsRecord.fromSnapshot(s));

  static Future<TransactionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TransactionsRecord.fromSnapshot(s));

  static TransactionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TransactionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TransactionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TransactionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TransactionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TransactionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTransactionsRecordData({
  DateTime? date,
  DocumentReference? staff,
  double? total,
  String? hotel,
  String? type,
  DocumentReference? booking,
  int? guests,
  int? room,
  String? description,
  bool? remitted,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'date': date,
      'staff': staff,
      'total': total,
      'hotel': hotel,
      'type': type,
      'booking': booking,
      'guests': guests,
      'room': room,
      'description': description,
      'remitted': remitted,
    }.withoutNulls,
  );

  return firestoreData;
}

class TransactionsRecordDocumentEquality
    implements Equality<TransactionsRecord> {
  const TransactionsRecordDocumentEquality();

  @override
  bool equals(TransactionsRecord? e1, TransactionsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.date == e2?.date &&
        e1?.staff == e2?.staff &&
        e1?.total == e2?.total &&
        listEquality.equals(e1?.goods, e2?.goods) &&
        e1?.hotel == e2?.hotel &&
        e1?.type == e2?.type &&
        e1?.booking == e2?.booking &&
        e1?.guests == e2?.guests &&
        e1?.room == e2?.room &&
        e1?.description == e2?.description &&
        e1?.remitted == e2?.remitted;
  }

  @override
  int hash(TransactionsRecord? e) => const ListEquality().hash([
        e?.date,
        e?.staff,
        e?.total,
        e?.goods,
        e?.hotel,
        e?.type,
        e?.booking,
        e?.guests,
        e?.room,
        e?.description,
        e?.remitted
      ]);

  @override
  bool isValidKey(Object? o) => o is TransactionsRecord;
}
