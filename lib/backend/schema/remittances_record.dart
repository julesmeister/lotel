import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RemittancesRecord extends FirestoreRecord {
  RemittancesRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "transactions" field.
  List<DocumentReference>? _transactions;
  List<DocumentReference> get transactions => _transactions ?? const [];
  bool hasTransactions() => _transactions != null;

  // "collectedBy" field.
  DocumentReference? _collectedBy;
  DocumentReference? get collectedBy => _collectedBy;
  bool hasCollectedBy() => _collectedBy != null;

  // "preparedBy" field.
  DocumentReference? _preparedBy;
  DocumentReference? get preparedBy => _preparedBy;
  bool hasPreparedBy() => _preparedBy != null;

  // "hotel" field.
  String? _hotel;
  String get hotel => _hotel ?? '';
  bool hasHotel() => _hotel != null;

  // "gross" field.
  double? _gross;
  double get gross => _gross ?? 0.0;
  bool hasGross() => _gross != null;

  // "expenses" field.
  double? _expenses;
  double get expenses => _expenses ?? 0.0;
  bool hasExpenses() => _expenses != null;

  // "net" field.
  double? _net;
  double get net => _net ?? 0.0;
  bool hasNet() => _net != null;

  // "collected" field.
  bool? _collected;
  bool get collected => _collected ?? false;
  bool hasCollected() => _collected != null;

  // "bookings" field.
  List<DocumentReference>? _bookings;
  List<DocumentReference> get bookings => _bookings ?? const [];
  bool hasBookings() => _bookings != null;

  // "inventories" field.
  List<DocumentReference>? _inventories;
  List<DocumentReference> get inventories => _inventories ?? const [];
  bool hasInventories() => _inventories != null;

  // "absences" field.
  List<DocumentReference>? _absences;
  List<DocumentReference> get absences => _absences ?? const [];
  bool hasAbsences() => _absences != null;

  void _initializeFields() {
    _date = snapshotData['date'] as DateTime?;
    _transactions = getDataList(snapshotData['transactions']);
    _collectedBy = snapshotData['collectedBy'] as DocumentReference?;
    _preparedBy = snapshotData['preparedBy'] as DocumentReference?;
    _hotel = snapshotData['hotel'] as String?;
    _gross = castToType<double>(snapshotData['gross']);
    _expenses = castToType<double>(snapshotData['expenses']);
    _net = castToType<double>(snapshotData['net']);
    _collected = snapshotData['collected'] as bool?;
    _bookings = getDataList(snapshotData['bookings']);
    _inventories = getDataList(snapshotData['inventories']);
    _absences = getDataList(snapshotData['absences']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('remittances');

  static Stream<RemittancesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RemittancesRecord.fromSnapshot(s));

  static Future<RemittancesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RemittancesRecord.fromSnapshot(s));

  static RemittancesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RemittancesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RemittancesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RemittancesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RemittancesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RemittancesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRemittancesRecordData({
  DateTime? date,
  DocumentReference? collectedBy,
  DocumentReference? preparedBy,
  String? hotel,
  double? gross,
  double? expenses,
  double? net,
  bool? collected,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'date': date,
      'collectedBy': collectedBy,
      'preparedBy': preparedBy,
      'hotel': hotel,
      'gross': gross,
      'expenses': expenses,
      'net': net,
      'collected': collected,
    }.withoutNulls,
  );

  return firestoreData;
}

class RemittancesRecordDocumentEquality implements Equality<RemittancesRecord> {
  const RemittancesRecordDocumentEquality();

  @override
  bool equals(RemittancesRecord? e1, RemittancesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.date == e2?.date &&
        listEquality.equals(e1?.transactions, e2?.transactions) &&
        e1?.collectedBy == e2?.collectedBy &&
        e1?.preparedBy == e2?.preparedBy &&
        e1?.hotel == e2?.hotel &&
        e1?.gross == e2?.gross &&
        e1?.expenses == e2?.expenses &&
        e1?.net == e2?.net &&
        e1?.collected == e2?.collected &&
        listEquality.equals(e1?.bookings, e2?.bookings) &&
        listEquality.equals(e1?.inventories, e2?.inventories) &&
        listEquality.equals(e1?.absences, e2?.absences);
  }

  @override
  int hash(RemittancesRecord? e) => const ListEquality().hash([
        e?.date,
        e?.transactions,
        e?.collectedBy,
        e?.preparedBy,
        e?.hotel,
        e?.gross,
        e?.expenses,
        e?.net,
        e?.collected,
        e?.bookings,
        e?.inventories,
        e?.absences
      ]);

  @override
  bool isValidKey(Object? o) => o is RemittancesRecord;
}
