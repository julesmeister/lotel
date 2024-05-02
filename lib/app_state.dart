import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _role = prefs.getString('ff_role') ?? _role;
    });
    _safeInit(() {
      _hotel = prefs.getString('ff_hotel') ?? _hotel;
    });
    _safeInit(() {
      _bedPrice = prefs.getDouble('ff_bedPrice') ?? _bedPrice;
    });
    _safeInit(() {
      _lastRemit = prefs.containsKey('ff_lastRemit')
          ? DateTime.fromMillisecondsSinceEpoch(prefs.getInt('ff_lastRemit')!)
          : _lastRemit;
    });
    _safeInit(() {
      _statsReference =
          prefs.getString('ff_statsReference')?.ref ?? _statsReference;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_currentStats')) {
        try {
          final serializedData = prefs.getString('ff_currentStats') ?? '{}';
          _currentStats = CurrentStatsStruct.fromSerializableMap(
              jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _settingRef = prefs.getString('ff_settingRef')?.ref ?? _settingRef;
    });
    _safeInit(() {
      _extPricePerHr = prefs.getDouble('ff_extPricePerHr') ?? _extPricePerHr;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _role = 'generic';
  String get role => _role;
  set role(String value) {
    _role = value;
    prefs.setString('ff_role', value);
  }

  String _hotel = '';
  String get hotel => _hotel;
  set hotel(String value) {
    _hotel = value;
    prefs.setString('ff_hotel', value);
  }

  double _bedPrice = 0.0;
  double get bedPrice => _bedPrice;
  set bedPrice(double value) {
    _bedPrice = value;
    prefs.setDouble('ff_bedPrice', value);
  }

  DateTime? _lastRemit = DateTime.fromMillisecondsSinceEpoch(1697548080000);
  DateTime? get lastRemit => _lastRemit;
  set lastRemit(DateTime? value) {
    _lastRemit = value;
    value != null
        ? prefs.setInt('ff_lastRemit', value.millisecondsSinceEpoch)
        : prefs.remove('ff_lastRemit');
  }

  DocumentReference? _statsReference;
  DocumentReference? get statsReference => _statsReference;
  set statsReference(DocumentReference? value) {
    _statsReference = value;
    value != null
        ? prefs.setString('ff_statsReference', value.path)
        : prefs.remove('ff_statsReference');
  }

  CurrentStatsStruct _currentStats = CurrentStatsStruct();
  CurrentStatsStruct get currentStats => _currentStats;
  set currentStats(CurrentStatsStruct value) {
    _currentStats = value;
    prefs.setString('ff_currentStats', value.serialize());
  }

  void updateCurrentStatsStruct(Function(CurrentStatsStruct) updateFn) {
    updateFn(_currentStats);
    prefs.setString('ff_currentStats', _currentStats.serialize());
  }

  DocumentReference? _settingRef;
  DocumentReference? get settingRef => _settingRef;
  set settingRef(DocumentReference? value) {
    _settingRef = value;
    value != null
        ? prefs.setString('ff_settingRef', value.path)
        : prefs.remove('ff_settingRef');
  }

  double _extPricePerHr = 0.0;
  double get extPricePerHr => _extPricePerHr;
  set extPricePerHr(double value) {
    _extPricePerHr = value;
    prefs.setDouble('ff_extPricePerHr', value);
  }

  int _loopCounter = 0;
  int get loopCounter => _loopCounter;
  set loopCounter(int value) {
    _loopCounter = value;
  }

  List<RoomUsageStruct> _roomUsages = [];
  List<RoomUsageStruct> get roomUsages => _roomUsages;
  set roomUsages(List<RoomUsageStruct> value) {
    _roomUsages = value;
  }

  void addToRoomUsages(RoomUsageStruct value) {
    _roomUsages.add(value);
  }

  void removeFromRoomUsages(RoomUsageStruct value) {
    _roomUsages.remove(value);
  }

  void removeAtIndexFromRoomUsages(int index) {
    _roomUsages.removeAt(index);
  }

  void updateRoomUsagesAtIndex(
    int index,
    RoomUsageStruct Function(RoomUsageStruct) updateFn,
  ) {
    _roomUsages[index] = updateFn(_roomUsages[index]);
  }

  void insertAtIndexInRoomUsages(int index, RoomUsageStruct value) {
    _roomUsages.insert(index, value);
  }

  final _roomsManager = StreamRequestManager<List<RoomsRecord>>();
  Stream<List<RoomsRecord>> rooms({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<RoomsRecord>> Function() requestFn,
  }) =>
      _roomsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearRoomsCache() => _roomsManager.clear();
  void clearRoomsCacheKey(String? uniqueKey) =>
      _roomsManager.clearRequest(uniqueKey);

  final _checkInCountManager = FutureRequestManager<List<RoomsRecord>>();
  Future<List<RoomsRecord>> checkInCount({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<RoomsRecord>> Function() requestFn,
  }) =>
      _checkInCountManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearCheckInCountCache() => _checkInCountManager.clear();
  void clearCheckInCountCacheKey(String? uniqueKey) =>
      _checkInCountManager.clearRequest(uniqueKey);

  final _hoteSettingsManager =
      StreamRequestManager<List<HotelSettingsRecord>>();
  Stream<List<HotelSettingsRecord>> hoteSettings({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<HotelSettingsRecord>> Function() requestFn,
  }) =>
      _hoteSettingsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearHoteSettingsCache() => _hoteSettingsManager.clear();
  void clearHoteSettingsCacheKey(String? uniqueKey) =>
      _hoteSettingsManager.clearRequest(uniqueKey);

  final _replenishCountManager = FutureRequestManager<int>();
  Future<int> replenishCount({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<int> Function() requestFn,
  }) =>
      _replenishCountManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearReplenishCountCache() => _replenishCountManager.clear();
  void clearReplenishCountCacheKey(String? uniqueKey) =>
      _replenishCountManager.clearRequest(uniqueKey);

  final _staffsManager = FutureRequestManager<int>();
  Future<int> staffs({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<int> Function() requestFn,
  }) =>
      _staffsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearStaffsCache() => _staffsManager.clear();
  void clearStaffsCacheKey(String? uniqueKey) =>
      _staffsManager.clearRequest(uniqueKey);

  final _groceryHomeManager =
      FutureRequestManager<List<GoodsRevenueRatioRecord>>();
  Future<List<GoodsRevenueRatioRecord>> groceryHome({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<GoodsRevenueRatioRecord>> Function() requestFn,
  }) =>
      _groceryHomeManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearGroceryHomeCache() => _groceryHomeManager.clear();
  void clearGroceryHomeCacheKey(String? uniqueKey) =>
      _groceryHomeManager.clearRequest(uniqueKey);

  final _statsSettingsManager = FutureRequestManager<StatsRecord>();
  Future<StatsRecord> statsSettings({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<StatsRecord> Function() requestFn,
  }) =>
      _statsSettingsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearStatsSettingsCache() => _statsSettingsManager.clear();
  void clearStatsSettingsCacheKey(String? uniqueKey) =>
      _statsSettingsManager.clearRequest(uniqueKey);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
