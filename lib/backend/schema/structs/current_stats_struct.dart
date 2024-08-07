// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class CurrentStatsStruct extends FFFirebaseStruct {
  CurrentStatsStruct({
    String? year,
    String? month,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _year = year,
        _month = month,
        super(firestoreUtilData);

  // "year" field.
  String? _year;
  String get year => _year ?? '';
  set year(String? val) => _year = val;

  bool hasYear() => _year != null;

  // "month" field.
  String? _month;
  String get month => _month ?? '';
  set month(String? val) => _month = val;

  bool hasMonth() => _month != null;

  static CurrentStatsStruct fromMap(Map<String, dynamic> data) =>
      CurrentStatsStruct(
        year: data['year'] as String?,
        month: data['month'] as String?,
      );

  static CurrentStatsStruct? maybeFromMap(dynamic data) => data is Map
      ? CurrentStatsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'year': _year,
        'month': _month,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'year': serializeParam(
          _year,
          ParamType.String,
        ),
        'month': serializeParam(
          _month,
          ParamType.String,
        ),
      }.withoutNulls;

  static CurrentStatsStruct fromSerializableMap(Map<String, dynamic> data) =>
      CurrentStatsStruct(
        year: deserializeParam(
          data['year'],
          ParamType.String,
          false,
        ),
        month: deserializeParam(
          data['month'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CurrentStatsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CurrentStatsStruct &&
        year == other.year &&
        month == other.month;
  }

  @override
  int get hashCode => const ListEquality().hash([year, month]);
}

CurrentStatsStruct createCurrentStatsStruct({
  String? year,
  String? month,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CurrentStatsStruct(
      year: year,
      month: month,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CurrentStatsStruct? updateCurrentStatsStruct(
  CurrentStatsStruct? currentStats, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    currentStats
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCurrentStatsStructData(
  Map<String, dynamic> firestoreData,
  CurrentStatsStruct? currentStats,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (currentStats == null) {
    return;
  }
  if (currentStats.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && currentStats.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final currentStatsData =
      getCurrentStatsFirestoreData(currentStats, forFieldValue);
  final nestedData =
      currentStatsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = currentStats.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCurrentStatsFirestoreData(
  CurrentStatsStruct? currentStats, [
  bool forFieldValue = false,
]) {
  if (currentStats == null) {
    return {};
  }
  final firestoreData = mapToFirestore(currentStats.toMap());

  // Add any Firestore field values
  currentStats.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCurrentStatsListFirestoreData(
  List<CurrentStatsStruct>? currentStatss,
) =>
    currentStatss?.map((e) => getCurrentStatsFirestoreData(e, true)).toList() ??
    [];
