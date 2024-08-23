// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RoomUsageStruct extends FFFirebaseStruct {
  RoomUsageStruct({
    int? number,
    int? use,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _number = number,
        _use = use,
        super(firestoreUtilData);

  // "number" field.
  int? _number;
  int get number => _number ?? 0;
  set number(int? val) => _number = val;

  void incrementNumber(int amount) => number = number + amount;

  bool hasNumber() => _number != null;

  // "use" field.
  int? _use;
  int get use => _use ?? 0;
  set use(int? val) => _use = val;

  void incrementUse(int amount) => use = use + amount;

  bool hasUse() => _use != null;

  static RoomUsageStruct fromMap(Map<String, dynamic> data) => RoomUsageStruct(
        number: castToType<int>(data['number']),
        use: castToType<int>(data['use']),
      );

  static RoomUsageStruct? maybeFromMap(dynamic data) => data is Map
      ? RoomUsageStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'number': _number,
        'use': _use,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'number': serializeParam(
          _number,
          ParamType.int,
        ),
        'use': serializeParam(
          _use,
          ParamType.int,
        ),
      }.withoutNulls;

  static RoomUsageStruct fromSerializableMap(Map<String, dynamic> data) =>
      RoomUsageStruct(
        number: deserializeParam(
          data['number'],
          ParamType.int,
          false,
        ),
        use: deserializeParam(
          data['use'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'RoomUsageStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RoomUsageStruct &&
        number == other.number &&
        use == other.use;
  }

  @override
  int get hashCode => const ListEquality().hash([number, use]);
}

RoomUsageStruct createRoomUsageStruct({
  int? number,
  int? use,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RoomUsageStruct(
      number: number,
      use: use,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RoomUsageStruct? updateRoomUsageStruct(
  RoomUsageStruct? roomUsage, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    roomUsage
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRoomUsageStructData(
  Map<String, dynamic> firestoreData,
  RoomUsageStruct? roomUsage,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (roomUsage == null) {
    return;
  }
  if (roomUsage.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && roomUsage.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final roomUsageData = getRoomUsageFirestoreData(roomUsage, forFieldValue);
  final nestedData = roomUsageData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = roomUsage.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRoomUsageFirestoreData(
  RoomUsageStruct? roomUsage, [
  bool forFieldValue = false,
]) {
  if (roomUsage == null) {
    return {};
  }
  final firestoreData = mapToFirestore(roomUsage.toMap());

  // Add any Firestore field values
  roomUsage.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRoomUsageListFirestoreData(
  List<RoomUsageStruct>? roomUsages,
) =>
    roomUsages?.map((e) => getRoomUsageFirestoreData(e, true)).toList() ?? [];
