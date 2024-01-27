// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RoomPendingStruct extends FFFirebaseStruct {
  RoomPendingStruct({
    DocumentReference? booking,
    int? room,
    double? total,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _booking = booking,
        _room = room,
        _total = total,
        super(firestoreUtilData);

  // "booking" field.
  DocumentReference? _booking;
  DocumentReference? get booking => _booking;
  set booking(DocumentReference? val) => _booking = val;
  bool hasBooking() => _booking != null;

  // "room" field.
  int? _room;
  int get room => _room ?? 0;
  set room(int? val) => _room = val;
  void incrementRoom(int amount) => _room = room + amount;
  bool hasRoom() => _room != null;

  // "total" field.
  double? _total;
  double get total => _total ?? 0.0;
  set total(double? val) => _total = val;
  void incrementTotal(double amount) => _total = total + amount;
  bool hasTotal() => _total != null;

  static RoomPendingStruct fromMap(Map<String, dynamic> data) =>
      RoomPendingStruct(
        booking: data['booking'] as DocumentReference?,
        room: castToType<int>(data['room']),
        total: castToType<double>(data['total']),
      );

  static RoomPendingStruct? maybeFromMap(dynamic data) => data is Map
      ? RoomPendingStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'booking': _booking,
        'room': _room,
        'total': _total,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'booking': serializeParam(
          _booking,
          ParamType.DocumentReference,
        ),
        'room': serializeParam(
          _room,
          ParamType.int,
        ),
        'total': serializeParam(
          _total,
          ParamType.double,
        ),
      }.withoutNulls;

  static RoomPendingStruct fromSerializableMap(Map<String, dynamic> data) =>
      RoomPendingStruct(
        booking: deserializeParam(
          data['booking'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['bookings'],
        ),
        room: deserializeParam(
          data['room'],
          ParamType.int,
          false,
        ),
        total: deserializeParam(
          data['total'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'RoomPendingStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RoomPendingStruct &&
        booking == other.booking &&
        room == other.room &&
        total == other.total;
  }

  @override
  int get hashCode => const ListEquality().hash([booking, room, total]);
}

RoomPendingStruct createRoomPendingStruct({
  DocumentReference? booking,
  int? room,
  double? total,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RoomPendingStruct(
      booking: booking,
      room: room,
      total: total,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RoomPendingStruct? updateRoomPendingStruct(
  RoomPendingStruct? roomPending, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    roomPending
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRoomPendingStructData(
  Map<String, dynamic> firestoreData,
  RoomPendingStruct? roomPending,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (roomPending == null) {
    return;
  }
  if (roomPending.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && roomPending.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final roomPendingData =
      getRoomPendingFirestoreData(roomPending, forFieldValue);
  final nestedData =
      roomPendingData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = roomPending.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRoomPendingFirestoreData(
  RoomPendingStruct? roomPending, [
  bool forFieldValue = false,
]) {
  if (roomPending == null) {
    return {};
  }
  final firestoreData = mapToFirestore(roomPending.toMap());

  // Add any Firestore field values
  roomPending.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRoomPendingListFirestoreData(
  List<RoomPendingStruct>? roomPendings,
) =>
    roomPendings?.map((e) => getRoomPendingFirestoreData(e, true)).toList() ??
    [];