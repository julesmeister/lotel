import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InventoriesRecord extends FirestoreRecord {
  InventoriesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "activity" field.
  String? _activity;
  String get activity => _activity ?? '';
  bool hasActivity() => _activity != null;

  // "hotel" field.
  String? _hotel;
  String get hotel => _hotel ?? '';
  bool hasHotel() => _hotel != null;

  // "staff" field.
  DocumentReference? _staff;
  DocumentReference? get staff => _staff;
  bool hasStaff() => _staff != null;

  // "quantityChange" field.
  int? _quantityChange;
  int get quantityChange => _quantityChange ?? 0;
  bool hasQuantityChange() => _quantityChange != null;

  // "previousQuantity" field.
  int? _previousQuantity;
  int get previousQuantity => _previousQuantity ?? 0;
  bool hasPreviousQuantity() => _previousQuantity != null;

  // "item" field.
  String? _item;
  String get item => _item ?? '';
  bool hasItem() => _item != null;

  // "operator" field.
  String? _operator;
  String get operator => _operator ?? '';
  bool hasOperator() => _operator != null;

  // "previousPrice" field.
  double? _previousPrice;
  double get previousPrice => _previousPrice ?? 0.0;
  bool hasPreviousPrice() => _previousPrice != null;

  // "priceChange" field.
  double? _priceChange;
  double get priceChange => _priceChange ?? 0.0;
  bool hasPriceChange() => _priceChange != null;

  // "remitted" field.
  bool? _remitted;
  bool get remitted => _remitted ?? false;
  bool hasRemitted() => _remitted != null;

  void _initializeFields() {
    _date = snapshotData['date'] as DateTime?;
    _activity = snapshotData['activity'] as String?;
    _hotel = snapshotData['hotel'] as String?;
    _staff = snapshotData['staff'] as DocumentReference?;
    _quantityChange = castToType<int>(snapshotData['quantityChange']);
    _previousQuantity = castToType<int>(snapshotData['previousQuantity']);
    _item = snapshotData['item'] as String?;
    _operator = snapshotData['operator'] as String?;
    _previousPrice = castToType<double>(snapshotData['previousPrice']);
    _priceChange = castToType<double>(snapshotData['priceChange']);
    _remitted = snapshotData['remitted'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('inventories');

  static Stream<InventoriesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => InventoriesRecord.fromSnapshot(s));

  static Future<InventoriesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => InventoriesRecord.fromSnapshot(s));

  static InventoriesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      InventoriesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static InventoriesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      InventoriesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'InventoriesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is InventoriesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createInventoriesRecordData({
  DateTime? date,
  String? activity,
  String? hotel,
  DocumentReference? staff,
  int? quantityChange,
  int? previousQuantity,
  String? item,
  String? operator,
  double? previousPrice,
  double? priceChange,
  bool? remitted,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'date': date,
      'activity': activity,
      'hotel': hotel,
      'staff': staff,
      'quantityChange': quantityChange,
      'previousQuantity': previousQuantity,
      'item': item,
      'operator': operator,
      'previousPrice': previousPrice,
      'priceChange': priceChange,
      'remitted': remitted,
    }.withoutNulls,
  );

  return firestoreData;
}

class InventoriesRecordDocumentEquality implements Equality<InventoriesRecord> {
  const InventoriesRecordDocumentEquality();

  @override
  bool equals(InventoriesRecord? e1, InventoriesRecord? e2) {
    return e1?.date == e2?.date &&
        e1?.activity == e2?.activity &&
        e1?.hotel == e2?.hotel &&
        e1?.staff == e2?.staff &&
        e1?.quantityChange == e2?.quantityChange &&
        e1?.previousQuantity == e2?.previousQuantity &&
        e1?.item == e2?.item &&
        e1?.operator == e2?.operator &&
        e1?.previousPrice == e2?.previousPrice &&
        e1?.priceChange == e2?.priceChange &&
        e1?.remitted == e2?.remitted;
  }

  @override
  int hash(InventoriesRecord? e) => const ListEquality().hash([
        e?.date,
        e?.activity,
        e?.hotel,
        e?.staff,
        e?.quantityChange,
        e?.previousQuantity,
        e?.item,
        e?.operator,
        e?.previousPrice,
        e?.priceChange,
        e?.remitted
      ]);

  @override
  bool isValidKey(Object? o) => o is InventoriesRecord;
}
