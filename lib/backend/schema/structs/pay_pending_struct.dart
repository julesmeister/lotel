// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PayPendingStruct extends FFFirebaseStruct {
  PayPendingStruct({
    double? amount,
    bool? pending,
    DocumentReference? ref,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _amount = amount,
        _pending = pending,
        _ref = ref,
        super(firestoreUtilData);

  // "amount" field.
  double? _amount;
  double get amount => _amount ?? 0.0;
  set amount(double? val) => _amount = val;

  void incrementAmount(double amount) => amount = amount + amount;

  bool hasAmount() => _amount != null;

  // "pending" field.
  bool? _pending;
  bool get pending => _pending ?? true;
  set pending(bool? val) => _pending = val;

  bool hasPending() => _pending != null;

  // "ref" field.
  DocumentReference? _ref;
  DocumentReference? get ref => _ref;
  set ref(DocumentReference? val) => _ref = val;

  bool hasRef() => _ref != null;

  static PayPendingStruct fromMap(Map<String, dynamic> data) =>
      PayPendingStruct(
        amount: castToType<double>(data['amount']),
        pending: data['pending'] as bool?,
        ref: data['ref'] as DocumentReference?,
      );

  static PayPendingStruct? maybeFromMap(dynamic data) => data is Map
      ? PayPendingStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'amount': _amount,
        'pending': _pending,
        'ref': _ref,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'amount': serializeParam(
          _amount,
          ParamType.double,
        ),
        'pending': serializeParam(
          _pending,
          ParamType.bool,
        ),
        'ref': serializeParam(
          _ref,
          ParamType.DocumentReference,
        ),
      }.withoutNulls;

  static PayPendingStruct fromSerializableMap(Map<String, dynamic> data) =>
      PayPendingStruct(
        amount: deserializeParam(
          data['amount'],
          ParamType.double,
          false,
        ),
        pending: deserializeParam(
          data['pending'],
          ParamType.bool,
          false,
        ),
        ref: deserializeParam(
          data['ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['transactions'],
        ),
      );

  @override
  String toString() => 'PayPendingStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PayPendingStruct &&
        amount == other.amount &&
        pending == other.pending &&
        ref == other.ref;
  }

  @override
  int get hashCode => const ListEquality().hash([amount, pending, ref]);
}

PayPendingStruct createPayPendingStruct({
  double? amount,
  bool? pending,
  DocumentReference? ref,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PayPendingStruct(
      amount: amount,
      pending: pending,
      ref: ref,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PayPendingStruct? updatePayPendingStruct(
  PayPendingStruct? payPending, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    payPending
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPayPendingStructData(
  Map<String, dynamic> firestoreData,
  PayPendingStruct? payPending,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (payPending == null) {
    return;
  }
  if (payPending.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && payPending.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final payPendingData = getPayPendingFirestoreData(payPending, forFieldValue);
  final nestedData = payPendingData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = payPending.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPayPendingFirestoreData(
  PayPendingStruct? payPending, [
  bool forFieldValue = false,
]) {
  if (payPending == null) {
    return {};
  }
  final firestoreData = mapToFirestore(payPending.toMap());

  // Add any Firestore field values
  payPending.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPayPendingListFirestoreData(
  List<PayPendingStruct>? payPendings,
) =>
    payPendings?.map((e) => getPayPendingFirestoreData(e, true)).toList() ?? [];
