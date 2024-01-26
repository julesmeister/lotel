import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SalariesRecord extends FirestoreRecord {
  SalariesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "sss" field.
  double? _sss;
  double get sss => _sss ?? 0.0;
  bool hasSss() => _sss != null;

  // "cashAdvance" field.
  double? _cashAdvance;
  double get cashAdvance => _cashAdvance ?? 0.0;
  bool hasCashAdvance() => _cashAdvance != null;

  // "total" field.
  double? _total;
  double get total => _total ?? 0.0;
  bool hasTotal() => _total != null;

  // "pendingCA" field.
  double? _pendingCA;
  double get pendingCA => _pendingCA ?? 0.0;
  bool hasPendingCA() => _pendingCA != null;

  // "staff" field.
  DocumentReference? _staff;
  DocumentReference? get staff => _staff;
  bool hasStaff() => _staff != null;

  // "rate" field.
  double? _rate;
  double get rate => _rate ?? 0.0;
  bool hasRate() => _rate != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "caRefs" field.
  List<DocumentReference>? _caRefs;
  List<DocumentReference> get caRefs => _caRefs ?? const [];
  bool hasCaRefs() => _caRefs != null;

  // "absences" field.
  double? _absences;
  double get absences => _absences ?? 0.0;
  bool hasAbsences() => _absences != null;

  // "absencesRefs" field.
  List<DocumentReference>? _absencesRefs;
  List<DocumentReference> get absencesRefs => _absencesRefs ?? const [];
  bool hasAbsencesRefs() => _absencesRefs != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _sss = castToType<double>(snapshotData['sss']);
    _cashAdvance = castToType<double>(snapshotData['cashAdvance']);
    _total = castToType<double>(snapshotData['total']);
    _pendingCA = castToType<double>(snapshotData['pendingCA']);
    _staff = snapshotData['staff'] as DocumentReference?;
    _rate = castToType<double>(snapshotData['rate']);
    _date = snapshotData['date'] as DateTime?;
    _caRefs = getDataList(snapshotData['caRefs']);
    _absences = castToType<double>(snapshotData['absences']);
    _absencesRefs = getDataList(snapshotData['absencesRefs']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('salaries')
          : FirebaseFirestore.instance.collectionGroup('salaries');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('salaries').doc(id);

  static Stream<SalariesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SalariesRecord.fromSnapshot(s));

  static Future<SalariesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SalariesRecord.fromSnapshot(s));

  static SalariesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SalariesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SalariesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SalariesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SalariesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SalariesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSalariesRecordData({
  double? sss,
  double? cashAdvance,
  double? total,
  double? pendingCA,
  DocumentReference? staff,
  double? rate,
  DateTime? date,
  double? absences,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'sss': sss,
      'cashAdvance': cashAdvance,
      'total': total,
      'pendingCA': pendingCA,
      'staff': staff,
      'rate': rate,
      'date': date,
      'absences': absences,
    }.withoutNulls,
  );

  return firestoreData;
}

class SalariesRecordDocumentEquality implements Equality<SalariesRecord> {
  const SalariesRecordDocumentEquality();

  @override
  bool equals(SalariesRecord? e1, SalariesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.sss == e2?.sss &&
        e1?.cashAdvance == e2?.cashAdvance &&
        e1?.total == e2?.total &&
        e1?.pendingCA == e2?.pendingCA &&
        e1?.staff == e2?.staff &&
        e1?.rate == e2?.rate &&
        e1?.date == e2?.date &&
        listEquality.equals(e1?.caRefs, e2?.caRefs) &&
        e1?.absences == e2?.absences &&
        listEquality.equals(e1?.absencesRefs, e2?.absencesRefs);
  }

  @override
  int hash(SalariesRecord? e) => const ListEquality().hash([
        e?.sss,
        e?.cashAdvance,
        e?.total,
        e?.pendingCA,
        e?.staff,
        e?.rate,
        e?.date,
        e?.caRefs,
        e?.absences,
        e?.absencesRefs
      ]);

  @override
  bool isValidKey(Object? o) => o is SalariesRecord;
}
