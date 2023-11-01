import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GoodsRecord extends FirestoreRecord {
  GoodsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "quantity" field.
  int? _quantity;
  int get quantity => _quantity ?? 0;
  bool hasQuantity() => _quantity != null;

  // "hotel" field.
  String? _hotel;
  String get hotel => _hotel ?? '';
  bool hasHotel() => _hotel != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "replenish" field.
  bool? _replenish;
  bool get replenish => _replenish ?? false;
  bool hasReplenish() => _replenish != null;

  void _initializeFields() {
    _price = castToType<double>(snapshotData['price']);
    _quantity = castToType<int>(snapshotData['quantity']);
    _hotel = snapshotData['hotel'] as String?;
    _category = snapshotData['category'] as String?;
    _description = snapshotData['description'] as String?;
    _replenish = snapshotData['replenish'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('goods');

  static Stream<GoodsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GoodsRecord.fromSnapshot(s));

  static Future<GoodsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GoodsRecord.fromSnapshot(s));

  static GoodsRecord fromSnapshot(DocumentSnapshot snapshot) => GoodsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GoodsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GoodsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'GoodsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GoodsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGoodsRecordData({
  double? price,
  int? quantity,
  String? hotel,
  String? category,
  String? description,
  bool? replenish,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'price': price,
      'quantity': quantity,
      'hotel': hotel,
      'category': category,
      'description': description,
      'replenish': replenish,
    }.withoutNulls,
  );

  return firestoreData;
}

class GoodsRecordDocumentEquality implements Equality<GoodsRecord> {
  const GoodsRecordDocumentEquality();

  @override
  bool equals(GoodsRecord? e1, GoodsRecord? e2) {
    return e1?.price == e2?.price &&
        e1?.quantity == e2?.quantity &&
        e1?.hotel == e2?.hotel &&
        e1?.category == e2?.category &&
        e1?.description == e2?.description &&
        e1?.replenish == e2?.replenish;
  }

  @override
  int hash(GoodsRecord? e) => const ListEquality().hash([
        e?.price,
        e?.quantity,
        e?.hotel,
        e?.category,
        e?.description,
        e?.replenish
      ]);

  @override
  bool isValidKey(Object? o) => o is GoodsRecord;
}
