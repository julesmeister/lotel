import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';

class LastLoginRecord extends FirestoreRecord {
  LastLoginRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "datetime" field.
  DateTime? _datetime;
  DateTime? get datetime => _datetime;
  bool hasDatetime() => _datetime != null;

  // "hotel" field.
  String? _hotel;
  String get hotel => _hotel ?? '';
  bool hasHotel() => _hotel != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _datetime = snapshotData['datetime'] as DateTime?;
    _hotel = snapshotData['hotel'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('last_login')
          : FirebaseFirestore.instance.collectionGroup('last_login');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('last_login').doc(id);

  static Stream<LastLoginRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => LastLoginRecord.fromSnapshot(s));

  static Future<LastLoginRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => LastLoginRecord.fromSnapshot(s));

  static LastLoginRecord fromSnapshot(DocumentSnapshot snapshot) =>
      LastLoginRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static LastLoginRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      LastLoginRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'LastLoginRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is LastLoginRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createLastLoginRecordData({
  DateTime? datetime,
  String? hotel,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'datetime': datetime,
      'hotel': hotel,
    }.withoutNulls,
  );

  return firestoreData;
}

class LastLoginRecordDocumentEquality implements Equality<LastLoginRecord> {
  const LastLoginRecordDocumentEquality();

  @override
  bool equals(LastLoginRecord? e1, LastLoginRecord? e2) {
    return e1?.datetime == e2?.datetime && e1?.hotel == e2?.hotel;
  }

  @override
  int hash(LastLoginRecord? e) =>
      const ListEquality().hash([e?.datetime, e?.hotel]);

  @override
  bool isValidKey(Object? o) => o is LastLoginRecord;
}
