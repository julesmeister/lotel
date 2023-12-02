import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BookingsRecord extends FirestoreRecord {
  BookingsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "nights" field.
  int? _nights;
  int get nights => _nights ?? 0;
  bool hasNights() => _nights != null;

  // "total" field.
  double? _total;
  double get total => _total ?? 0.0;
  bool hasTotal() => _total != null;

  // "room" field.
  DocumentReference? _room;
  DocumentReference? get room => _room;
  bool hasRoom() => _room != null;

  // "details" field.
  String? _details;
  String get details => _details ?? '';
  bool hasDetails() => _details != null;

  // "contact" field.
  String? _contact;
  String get contact => _contact ?? '';
  bool hasContact() => _contact != null;

  // "dateIn" field.
  DateTime? _dateIn;
  DateTime? get dateIn => _dateIn;
  bool hasDateIn() => _dateIn != null;

  // "dateOut" field.
  DateTime? _dateOut;
  DateTime? get dateOut => _dateOut;
  bool hasDateOut() => _dateOut != null;

  // "hotel" field.
  String? _hotel;
  String get hotel => _hotel ?? '';
  bool hasHotel() => _hotel != null;

  // "extraBeds" field.
  String? _extraBeds;
  String get extraBeds => _extraBeds ?? '';
  bool hasExtraBeds() => _extraBeds != null;

  // "guests" field.
  String? _guests;
  String get guests => _guests ?? '';
  bool hasGuests() => _guests != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "staff" field.
  DocumentReference? _staff;
  DocumentReference? get staff => _staff;
  bool hasStaff() => _staff != null;

  // "pendings" field.
  List<DocumentReference>? _pendings;
  List<DocumentReference> get pendings => _pendings ?? const [];
  bool hasPendings() => _pendings != null;

  // "transactions" field.
  List<DocumentReference>? _transactions;
  List<DocumentReference> get transactions => _transactions ?? const [];
  bool hasTransactions() => _transactions != null;

  // "ability" field.
  String? _ability;
  String get ability => _ability ?? '';
  bool hasAbility() => _ability != null;

  void _initializeFields() {
    _nights = castToType<int>(snapshotData['nights']);
    _total = castToType<double>(snapshotData['total']);
    _room = snapshotData['room'] as DocumentReference?;
    _details = snapshotData['details'] as String?;
    _contact = snapshotData['contact'] as String?;
    _dateIn = snapshotData['dateIn'] as DateTime?;
    _dateOut = snapshotData['dateOut'] as DateTime?;
    _hotel = snapshotData['hotel'] as String?;
    _extraBeds = snapshotData['extraBeds'] as String?;
    _guests = snapshotData['guests'] as String?;
    _status = snapshotData['status'] as String?;
    _staff = snapshotData['staff'] as DocumentReference?;
    _pendings = getDataList(snapshotData['pendings']);
    _transactions = getDataList(snapshotData['transactions']);
    _ability = snapshotData['ability'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('bookings');

  static Stream<BookingsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => BookingsRecord.fromSnapshot(s));

  static Future<BookingsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => BookingsRecord.fromSnapshot(s));

  static BookingsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      BookingsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static BookingsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      BookingsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'BookingsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is BookingsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createBookingsRecordData({
  int? nights,
  double? total,
  DocumentReference? room,
  String? details,
  String? contact,
  DateTime? dateIn,
  DateTime? dateOut,
  String? hotel,
  String? extraBeds,
  String? guests,
  String? status,
  DocumentReference? staff,
  String? ability,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'nights': nights,
      'total': total,
      'room': room,
      'details': details,
      'contact': contact,
      'dateIn': dateIn,
      'dateOut': dateOut,
      'hotel': hotel,
      'extraBeds': extraBeds,
      'guests': guests,
      'status': status,
      'staff': staff,
      'ability': ability,
    }.withoutNulls,
  );

  return firestoreData;
}

class BookingsRecordDocumentEquality implements Equality<BookingsRecord> {
  const BookingsRecordDocumentEquality();

  @override
  bool equals(BookingsRecord? e1, BookingsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.nights == e2?.nights &&
        e1?.total == e2?.total &&
        e1?.room == e2?.room &&
        e1?.details == e2?.details &&
        e1?.contact == e2?.contact &&
        e1?.dateIn == e2?.dateIn &&
        e1?.dateOut == e2?.dateOut &&
        e1?.hotel == e2?.hotel &&
        e1?.extraBeds == e2?.extraBeds &&
        e1?.guests == e2?.guests &&
        e1?.status == e2?.status &&
        e1?.staff == e2?.staff &&
        listEquality.equals(e1?.pendings, e2?.pendings) &&
        listEquality.equals(e1?.transactions, e2?.transactions) &&
        e1?.ability == e2?.ability;
  }

  @override
  int hash(BookingsRecord? e) => const ListEquality().hash([
        e?.nights,
        e?.total,
        e?.room,
        e?.details,
        e?.contact,
        e?.dateIn,
        e?.dateOut,
        e?.hotel,
        e?.extraBeds,
        e?.guests,
        e?.status,
        e?.staff,
        e?.pendings,
        e?.transactions,
        e?.ability
      ]);

  @override
  bool isValidKey(Object? o) => o is BookingsRecord;
}
