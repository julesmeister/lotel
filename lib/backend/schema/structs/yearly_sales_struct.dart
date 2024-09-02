// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class YearlySalesStruct extends FFFirebaseStruct {
  YearlySalesStruct({
    String? month,
    double? sales,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _month = month,
        _sales = sales,
        super(firestoreUtilData);

  // "month" field.
  String? _month;
  String get month => _month ?? 'January';
  set month(String? val) => _month = val;

  bool hasMonth() => _month != null;

  // "sales" field.
  double? _sales;
  double get sales => _sales ?? 0.0;
  set sales(double? val) => _sales = val;

  void incrementSales(double amount) => sales = sales + amount;

  bool hasSales() => _sales != null;

  static YearlySalesStruct fromMap(Map<String, dynamic> data) =>
      YearlySalesStruct(
        month: data['month'] as String?,
        sales: castToType<double>(data['sales']),
      );

  static YearlySalesStruct? maybeFromMap(dynamic data) => data is Map
      ? YearlySalesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'month': _month,
        'sales': _sales,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'month': serializeParam(
          _month,
          ParamType.String,
        ),
        'sales': serializeParam(
          _sales,
          ParamType.double,
        ),
      }.withoutNulls;

  static YearlySalesStruct fromSerializableMap(Map<String, dynamic> data) =>
      YearlySalesStruct(
        month: deserializeParam(
          data['month'],
          ParamType.String,
          false,
        ),
        sales: deserializeParam(
          data['sales'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'YearlySalesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is YearlySalesStruct &&
        month == other.month &&
        sales == other.sales;
  }

  @override
  int get hashCode => const ListEquality().hash([month, sales]);
}

YearlySalesStruct createYearlySalesStruct({
  String? month,
  double? sales,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    YearlySalesStruct(
      month: month,
      sales: sales,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

YearlySalesStruct? updateYearlySalesStruct(
  YearlySalesStruct? yearlySales, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    yearlySales
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addYearlySalesStructData(
  Map<String, dynamic> firestoreData,
  YearlySalesStruct? yearlySales,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (yearlySales == null) {
    return;
  }
  if (yearlySales.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && yearlySales.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final yearlySalesData =
      getYearlySalesFirestoreData(yearlySales, forFieldValue);
  final nestedData =
      yearlySalesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = yearlySales.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getYearlySalesFirestoreData(
  YearlySalesStruct? yearlySales, [
  bool forFieldValue = false,
]) {
  if (yearlySales == null) {
    return {};
  }
  final firestoreData = mapToFirestore(yearlySales.toMap());

  // Add any Firestore field values
  yearlySales.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getYearlySalesListFirestoreData(
  List<YearlySalesStruct>? yearlySaless,
) =>
    yearlySaless?.map((e) => getYearlySalesFirestoreData(e, true)).toList() ??
    [];
