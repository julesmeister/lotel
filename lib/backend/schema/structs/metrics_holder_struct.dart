// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MetricsHolderStruct extends FFFirebaseStruct {
  MetricsHolderStruct({
    double? rooms,
    double? goods,
    double? expenses,
    double? salaries,
    double? bills,
    double? net,
    String? hotel,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _rooms = rooms,
        _goods = goods,
        _expenses = expenses,
        _salaries = salaries,
        _bills = bills,
        _net = net,
        _hotel = hotel,
        super(firestoreUtilData);

  // "rooms" field.
  double? _rooms;
  double get rooms => _rooms ?? 0.0;
  set rooms(double? val) => _rooms = val;
  void incrementRooms(double amount) => _rooms = rooms + amount;
  bool hasRooms() => _rooms != null;

  // "goods" field.
  double? _goods;
  double get goods => _goods ?? 0.0;
  set goods(double? val) => _goods = val;
  void incrementGoods(double amount) => _goods = goods + amount;
  bool hasGoods() => _goods != null;

  // "expenses" field.
  double? _expenses;
  double get expenses => _expenses ?? 0.0;
  set expenses(double? val) => _expenses = val;
  void incrementExpenses(double amount) => _expenses = expenses + amount;
  bool hasExpenses() => _expenses != null;

  // "salaries" field.
  double? _salaries;
  double get salaries => _salaries ?? 0.0;
  set salaries(double? val) => _salaries = val;
  void incrementSalaries(double amount) => _salaries = salaries + amount;
  bool hasSalaries() => _salaries != null;

  // "bills" field.
  double? _bills;
  double get bills => _bills ?? 0.0;
  set bills(double? val) => _bills = val;
  void incrementBills(double amount) => _bills = bills + amount;
  bool hasBills() => _bills != null;

  // "net" field.
  double? _net;
  double get net => _net ?? 0.0;
  set net(double? val) => _net = val;
  void incrementNet(double amount) => _net = net + amount;
  bool hasNet() => _net != null;

  // "hotel" field.
  String? _hotel;
  String get hotel => _hotel ?? '';
  set hotel(String? val) => _hotel = val;
  bool hasHotel() => _hotel != null;

  static MetricsHolderStruct fromMap(Map<String, dynamic> data) =>
      MetricsHolderStruct(
        rooms: castToType<double>(data['rooms']),
        goods: castToType<double>(data['goods']),
        expenses: castToType<double>(data['expenses']),
        salaries: castToType<double>(data['salaries']),
        bills: castToType<double>(data['bills']),
        net: castToType<double>(data['net']),
        hotel: data['hotel'] as String?,
      );

  static MetricsHolderStruct? maybeFromMap(dynamic data) => data is Map
      ? MetricsHolderStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'rooms': _rooms,
        'goods': _goods,
        'expenses': _expenses,
        'salaries': _salaries,
        'bills': _bills,
        'net': _net,
        'hotel': _hotel,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'rooms': serializeParam(
          _rooms,
          ParamType.double,
        ),
        'goods': serializeParam(
          _goods,
          ParamType.double,
        ),
        'expenses': serializeParam(
          _expenses,
          ParamType.double,
        ),
        'salaries': serializeParam(
          _salaries,
          ParamType.double,
        ),
        'bills': serializeParam(
          _bills,
          ParamType.double,
        ),
        'net': serializeParam(
          _net,
          ParamType.double,
        ),
        'hotel': serializeParam(
          _hotel,
          ParamType.String,
        ),
      }.withoutNulls;

  static MetricsHolderStruct fromSerializableMap(Map<String, dynamic> data) =>
      MetricsHolderStruct(
        rooms: deserializeParam(
          data['rooms'],
          ParamType.double,
          false,
        ),
        goods: deserializeParam(
          data['goods'],
          ParamType.double,
          false,
        ),
        expenses: deserializeParam(
          data['expenses'],
          ParamType.double,
          false,
        ),
        salaries: deserializeParam(
          data['salaries'],
          ParamType.double,
          false,
        ),
        bills: deserializeParam(
          data['bills'],
          ParamType.double,
          false,
        ),
        net: deserializeParam(
          data['net'],
          ParamType.double,
          false,
        ),
        hotel: deserializeParam(
          data['hotel'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'MetricsHolderStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MetricsHolderStruct &&
        rooms == other.rooms &&
        goods == other.goods &&
        expenses == other.expenses &&
        salaries == other.salaries &&
        bills == other.bills &&
        net == other.net &&
        hotel == other.hotel;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([rooms, goods, expenses, salaries, bills, net, hotel]);
}

MetricsHolderStruct createMetricsHolderStruct({
  double? rooms,
  double? goods,
  double? expenses,
  double? salaries,
  double? bills,
  double? net,
  String? hotel,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    MetricsHolderStruct(
      rooms: rooms,
      goods: goods,
      expenses: expenses,
      salaries: salaries,
      bills: bills,
      net: net,
      hotel: hotel,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

MetricsHolderStruct? updateMetricsHolderStruct(
  MetricsHolderStruct? metricsHolder, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    metricsHolder
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addMetricsHolderStructData(
  Map<String, dynamic> firestoreData,
  MetricsHolderStruct? metricsHolder,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (metricsHolder == null) {
    return;
  }
  if (metricsHolder.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && metricsHolder.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final metricsHolderData =
      getMetricsHolderFirestoreData(metricsHolder, forFieldValue);
  final nestedData =
      metricsHolderData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = metricsHolder.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getMetricsHolderFirestoreData(
  MetricsHolderStruct? metricsHolder, [
  bool forFieldValue = false,
]) {
  if (metricsHolder == null) {
    return {};
  }
  final firestoreData = mapToFirestore(metricsHolder.toMap());

  // Add any Firestore field values
  metricsHolder.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getMetricsHolderListFirestoreData(
  List<MetricsHolderStruct>? metricsHolders,
) =>
    metricsHolders
        ?.map((e) => getMetricsHolderFirestoreData(e, true))
        .toList() ??
    [];
