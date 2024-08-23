// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RoomPendingStruct extends FFFirebaseStruct {
  RoomPendingStruct({
    DocumentReference? booking,
    int? room,
    double? total,
    DateTime? since,
    int? quantity,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _booking = booking,
        _room = room,
        _total = total,
        _since = since,
        _quantity = quantity,
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

  void incrementRoom(int amount) => room = room + amount;

  bool hasRoom() => _room != null;

  // "total" field.
  double? _total;
  double get total => _total ?? 0.0;
  set total(double? val) => _total = val;

  void incrementTotal(double amount) => total = total + amount;

  bool hasTotal() => _total != null;

  // "since" field.
  DateTime? _since;
  DateTime? get since => _since;
  set since(DateTime? val) => _since = val;

  bool hasSince() => _since != null;

  // "quantity" field.
  int? _quantity;
  int get quantity => _quantity ?? 1;
  set quantity(int? val) => _quantity = val;

  void incrementQuantity(int amount) => quantity = quantity + amount;

  bool hasQuantity() => _quantity != null;

  static RoomPendingStruct fromMap(Map<String, dynamic> data) =>
      RoomPendingStruct(
        booking: data['booking'] as DocumentReference?,
        room: castToType<int>(data['room']),
        total: castToType<double>(data['total']),
        since: data['since'] as DateTime?,
        quantity: castToType<int>(data['quantity']),
      );

  static RoomPendingStruct? maybeFromMap(dynamic data) => data is Map
      ? RoomPendingStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'booking': _booking,
        'room': _room,
        'total': _total,
        'since': _since,
        'quantity': _quantity,
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
        'since': serializeParam(
          _since,
          ParamType.DateTime,
        ),
        'quantity': serializeParam(
          _quantity,
          ParamType.int,
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
        since: deserializeParam(
          data['since'],
          ParamType.DateTime,
          false,
        ),
        quantity: deserializeParam(
          data['quantity'],
          ParamType.int,
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
        total == other.total &&
        since == other.since &&
        quantity == other.quantity;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([booking, room, total, since, quantity]);
}

RoomPendingStruct createRoomPendingStruct({
  DocumentReference? booking,
  int? room,
  double? total,
  DateTime? since,
  int? quantity,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RoomPendingStruct(
      booking: booking,
      room: room,
      total: total,
      since: since,
      quantity: quantity,
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
