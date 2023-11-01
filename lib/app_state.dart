import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
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
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _role = 'generic';
  String get role => _role;
  set role(String _value) {
    _role = _value;
    prefs.setString('ff_role', _value);
  }

  String _hotel = '';
  String get hotel => _hotel;
  set hotel(String _value) {
    _hotel = _value;
    prefs.setString('ff_hotel', _value);
  }

  double _bedPrice = 0.0;
  double get bedPrice => _bedPrice;
  set bedPrice(double _value) {
    _bedPrice = _value;
    prefs.setDouble('ff_bedPrice', _value);
  }

  DateTime? _lastRemit = DateTime.fromMillisecondsSinceEpoch(1697548080000);
  DateTime? get lastRemit => _lastRemit;
  set lastRemit(DateTime? _value) {
    _lastRemit = _value;
    _value != null
        ? prefs.setInt('ff_lastRemit', _value.millisecondsSinceEpoch)
        : prefs.remove('ff_lastRemit');
  }

  DocumentReference? _statsReference;
  DocumentReference? get statsReference => _statsReference;
  set statsReference(DocumentReference? _value) {
    _statsReference = _value;
    _value != null
        ? prefs.setString('ff_statsReference', _value.path)
        : prefs.remove('ff_statsReference');
  }

  CurrentStatsStruct _currentStats = CurrentStatsStruct();
  CurrentStatsStruct get currentStats => _currentStats;
  set currentStats(CurrentStatsStruct _value) {
    _currentStats = _value;
    prefs.setString('ff_currentStats', _value.serialize());
  }

  void updateCurrentStatsStruct(Function(CurrentStatsStruct) updateFn) {
    updateFn(_currentStats);
    prefs.setString('ff_currentStats', _currentStats.serialize());
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

  final _checkInCountManager = FutureRequestManager<int>();
  Future<int> checkInCount({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<int> Function() requestFn,
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

  final _issuesHomeManager = StreamRequestManager<List<IssuesRecord>>();
  Stream<List<IssuesRecord>> issuesHome({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<IssuesRecord>> Function() requestFn,
  }) =>
      _issuesHomeManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearIssuesHomeCache() => _issuesHomeManager.clear();
  void clearIssuesHomeCacheKey(String? uniqueKey) =>
      _issuesHomeManager.clearRequest(uniqueKey);

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

  final _issuedManager = FutureRequestManager<int>();
  Future<int> issued({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<int> Function() requestFn,
  }) =>
      _issuedManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearIssuedCache() => _issuedManager.clear();
  void clearIssuedCacheKey(String? uniqueKey) =>
      _issuedManager.clearRequest(uniqueKey);
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
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
