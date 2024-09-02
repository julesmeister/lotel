import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class HotelSettingsRecord extends FirestoreRecord {
  HotelSettingsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "bedPrice" field.
  double? _bedPrice;
  double get bedPrice => _bedPrice ?? 0.0;
  bool hasBedPrice() => _bedPrice != null;

  // "hotel" field.
  String? _hotel;
  String get hotel => _hotel ?? '';
  bool hasHotel() => _hotel != null;

  // "lastRemit" field.
  DateTime? _lastRemit;
  DateTime? get lastRemit => _lastRemit;
  bool hasLastRemit() => _lastRemit != null;

  // "acceptNewStaff" field.
  bool? _acceptNewStaff;
  bool get acceptNewStaff => _acceptNewStaff ?? false;
  bool hasAcceptNewStaff() => _acceptNewStaff != null;

  // "remittable" field.
  bool? _remittable;
  bool get remittable => _remittable ?? false;
  bool hasRemittable() => _remittable != null;

  // "lateCheckoutFee" field.
  double? _lateCheckoutFee;
  double get lateCheckoutFee => _lateCheckoutFee ?? 0.0;
  bool hasLateCheckoutFee() => _lateCheckoutFee != null;

  // "failedToRemitTransactions" field.
  List<DocumentReference>? _failedToRemitTransactions;
  List<DocumentReference> get failedToRemitTransactions =>
      _failedToRemitTransactions ?? const [];
  bool hasFailedToRemitTransactions() => _failedToRemitTransactions != null;

  // "collectable" field.
  bool? _collectable;
  bool get collectable => _collectable ?? false;
  bool hasCollectable() => _collectable != null;

  // "promoOn" field.
  bool? _promoOn;
  bool get promoOn => _promoOn ?? false;
  bool hasPromoOn() => _promoOn != null;

  // "promoDetail" field.
  String? _promoDetail;
  String get promoDetail => _promoDetail ?? '';
  bool hasPromoDetail() => _promoDetail != null;

  // "promoPercent" field.
  double? _promoPercent;
  double get promoPercent => _promoPercent ?? 0.0;
  bool hasPromoPercent() => _promoPercent != null;

  void _initializeFields() {
    _bedPrice = castToType<double>(snapshotData['bedPrice']);
    _hotel = snapshotData['hotel'] as String?;
    _lastRemit = snapshotData['lastRemit'] as DateTime?;
    _acceptNewStaff = snapshotData['acceptNewStaff'] as bool?;
    _remittable = snapshotData['remittable'] as bool?;
    _lateCheckoutFee = castToType<double>(snapshotData['lateCheckoutFee']);
    _failedToRemitTransactions =
        getDataList(snapshotData['failedToRemitTransactions']);
    _collectable = snapshotData['collectable'] as bool?;
    _promoOn = snapshotData['promoOn'] as bool?;
    _promoDetail = snapshotData['promoDetail'] as String?;
    _promoPercent = castToType<double>(snapshotData['promoPercent']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('hotel_settings');

  static Stream<HotelSettingsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => HotelSettingsRecord.fromSnapshot(s));

  static Future<HotelSettingsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => HotelSettingsRecord.fromSnapshot(s));

  static HotelSettingsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      HotelSettingsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static HotelSettingsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      HotelSettingsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'HotelSettingsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is HotelSettingsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createHotelSettingsRecordData({
  double? bedPrice,
  String? hotel,
  DateTime? lastRemit,
  bool? acceptNewStaff,
  bool? remittable,
  double? lateCheckoutFee,
  bool? collectable,
  bool? promoOn,
  String? promoDetail,
  double? promoPercent,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'bedPrice': bedPrice,
      'hotel': hotel,
      'lastRemit': lastRemit,
      'acceptNewStaff': acceptNewStaff,
      'remittable': remittable,
      'lateCheckoutFee': lateCheckoutFee,
      'collectable': collectable,
      'promoOn': promoOn,
      'promoDetail': promoDetail,
      'promoPercent': promoPercent,
    }.withoutNulls,
  );

  return firestoreData;
}

class HotelSettingsRecordDocumentEquality
    implements Equality<HotelSettingsRecord> {
  const HotelSettingsRecordDocumentEquality();

  @override
  bool equals(HotelSettingsRecord? e1, HotelSettingsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.bedPrice == e2?.bedPrice &&
        e1?.hotel == e2?.hotel &&
        e1?.lastRemit == e2?.lastRemit &&
        e1?.acceptNewStaff == e2?.acceptNewStaff &&
        e1?.remittable == e2?.remittable &&
        e1?.lateCheckoutFee == e2?.lateCheckoutFee &&
        listEquality.equals(
            e1?.failedToRemitTransactions, e2?.failedToRemitTransactions) &&
        e1?.collectable == e2?.collectable &&
        e1?.promoOn == e2?.promoOn &&
        e1?.promoDetail == e2?.promoDetail &&
        e1?.promoPercent == e2?.promoPercent;
  }

  @override
  int hash(HotelSettingsRecord? e) => const ListEquality().hash([
        e?.bedPrice,
        e?.hotel,
        e?.lastRemit,
        e?.acceptNewStaff,
        e?.remittable,
        e?.lateCheckoutFee,
        e?.failedToRemitTransactions,
        e?.collectable,
        e?.promoOn,
        e?.promoDetail,
        e?.promoPercent
      ]);

  @override
  bool isValidKey(Object? o) => o is HotelSettingsRecord;
}
