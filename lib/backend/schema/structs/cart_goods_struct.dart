// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CartGoodsStruct extends FFFirebaseStruct {
  CartGoodsStruct({
    String? description,
    int? quantity,
    double? price,
    int? previousQuantity,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _description = description,
        _quantity = quantity,
        _price = price,
        _previousQuantity = previousQuantity,
        super(firestoreUtilData);

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;
  bool hasDescription() => _description != null;

  // "quantity" field.
  int? _quantity;
  int get quantity => _quantity ?? 0;
  set quantity(int? val) => _quantity = val;
  void incrementQuantity(int amount) => _quantity = quantity + amount;
  bool hasQuantity() => _quantity != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  set price(double? val) => _price = val;
  void incrementPrice(double amount) => _price = price + amount;
  bool hasPrice() => _price != null;

  // "previousQuantity" field.
  int? _previousQuantity;
  int get previousQuantity => _previousQuantity ?? 0;
  set previousQuantity(int? val) => _previousQuantity = val;
  void incrementPreviousQuantity(int amount) =>
      _previousQuantity = previousQuantity + amount;
  bool hasPreviousQuantity() => _previousQuantity != null;

  static CartGoodsStruct fromMap(Map<String, dynamic> data) => CartGoodsStruct(
        description: data['description'] as String?,
        quantity: castToType<int>(data['quantity']),
        price: castToType<double>(data['price']),
        previousQuantity: castToType<int>(data['previousQuantity']),
      );

  static CartGoodsStruct? maybeFromMap(dynamic data) => data is Map
      ? CartGoodsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'description': _description,
        'quantity': _quantity,
        'price': _price,
        'previousQuantity': _previousQuantity,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'quantity': serializeParam(
          _quantity,
          ParamType.int,
        ),
        'price': serializeParam(
          _price,
          ParamType.double,
        ),
        'previousQuantity': serializeParam(
          _previousQuantity,
          ParamType.int,
        ),
      }.withoutNulls;

  static CartGoodsStruct fromSerializableMap(Map<String, dynamic> data) =>
      CartGoodsStruct(
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        quantity: deserializeParam(
          data['quantity'],
          ParamType.int,
          false,
        ),
        price: deserializeParam(
          data['price'],
          ParamType.double,
          false,
        ),
        previousQuantity: deserializeParam(
          data['previousQuantity'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'CartGoodsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CartGoodsStruct &&
        description == other.description &&
        quantity == other.quantity &&
        price == other.price &&
        previousQuantity == other.previousQuantity;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([description, quantity, price, previousQuantity]);
}

CartGoodsStruct createCartGoodsStruct({
  String? description,
  int? quantity,
  double? price,
  int? previousQuantity,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CartGoodsStruct(
      description: description,
      quantity: quantity,
      price: price,
      previousQuantity: previousQuantity,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CartGoodsStruct? updateCartGoodsStruct(
  CartGoodsStruct? cartGoods, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    cartGoods
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCartGoodsStructData(
  Map<String, dynamic> firestoreData,
  CartGoodsStruct? cartGoods,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (cartGoods == null) {
    return;
  }
  if (cartGoods.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && cartGoods.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final cartGoodsData = getCartGoodsFirestoreData(cartGoods, forFieldValue);
  final nestedData = cartGoodsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = cartGoods.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCartGoodsFirestoreData(
  CartGoodsStruct? cartGoods, [
  bool forFieldValue = false,
]) {
  if (cartGoods == null) {
    return {};
  }
  final firestoreData = mapToFirestore(cartGoods.toMap());

  // Add any Firestore field values
  cartGoods.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCartGoodsListFirestoreData(
  List<CartGoodsStruct>? cartGoodss,
) =>
    cartGoodss?.map((e) => getCartGoodsFirestoreData(e, true)).toList() ?? [];
