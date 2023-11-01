// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LineGraphStruct extends FFFirebaseStruct {
  LineGraphStruct({
    List<int>? xData,
    List<int>? yData,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _xData = xData,
        _yData = yData,
        super(firestoreUtilData);

  // "xData" field.
  List<int>? _xData;
  List<int> get xData => _xData ?? const [];
  set xData(List<int>? val) => _xData = val;
  void updateXData(Function(List<int>) updateFn) => updateFn(_xData ??= []);
  bool hasXData() => _xData != null;

  // "yData" field.
  List<int>? _yData;
  List<int> get yData => _yData ?? const [];
  set yData(List<int>? val) => _yData = val;
  void updateYData(Function(List<int>) updateFn) => updateFn(_yData ??= []);
  bool hasYData() => _yData != null;

  static LineGraphStruct fromMap(Map<String, dynamic> data) => LineGraphStruct(
        xData: getDataList(data['xData']),
        yData: getDataList(data['yData']),
      );

  static LineGraphStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic> ? LineGraphStruct.fromMap(data) : null;

  Map<String, dynamic> toMap() => {
        'xData': _xData,
        'yData': _yData,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'xData': serializeParam(
          _xData,
          ParamType.int,
          true,
        ),
        'yData': serializeParam(
          _yData,
          ParamType.int,
          true,
        ),
      }.withoutNulls;

  static LineGraphStruct fromSerializableMap(Map<String, dynamic> data) =>
      LineGraphStruct(
        xData: deserializeParam<int>(
          data['xData'],
          ParamType.int,
          true,
        ),
        yData: deserializeParam<int>(
          data['yData'],
          ParamType.int,
          true,
        ),
      );

  @override
  String toString() => 'LineGraphStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is LineGraphStruct &&
        listEquality.equals(xData, other.xData) &&
        listEquality.equals(yData, other.yData);
  }

  @override
  int get hashCode => const ListEquality().hash([xData, yData]);
}

LineGraphStruct createLineGraphStruct({
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LineGraphStruct(
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

LineGraphStruct? updateLineGraphStruct(
  LineGraphStruct? lineGraph, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    lineGraph
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLineGraphStructData(
  Map<String, dynamic> firestoreData,
  LineGraphStruct? lineGraph,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (lineGraph == null) {
    return;
  }
  if (lineGraph.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && lineGraph.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final lineGraphData = getLineGraphFirestoreData(lineGraph, forFieldValue);
  final nestedData = lineGraphData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = lineGraph.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLineGraphFirestoreData(
  LineGraphStruct? lineGraph, [
  bool forFieldValue = false,
]) {
  if (lineGraph == null) {
    return {};
  }
  final firestoreData = mapToFirestore(lineGraph.toMap());

  // Add any Firestore field values
  lineGraph.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLineGraphListFirestoreData(
  List<LineGraphStruct>? lineGraphs,
) =>
    lineGraphs?.map((e) => getLineGraphFirestoreData(e, true)).toList() ?? [];
