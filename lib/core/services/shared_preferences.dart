import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  final SharedPreferences _prefs;

  SharedPrefsService._(this._prefs);

  static Future<SharedPrefsService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return SharedPrefsService._(prefs);
  }

  // Save a string value
  Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  // Get a string value
  String? getString(String key) {
    return _prefs.getString(key);
  }

  // Save a bool value
  Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  // Get a bool value
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  // Save an int value
  Future<void> saveInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  // Get an int value
  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  // Save a double value
  Future<void> saveDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  // Get a double value
  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  // Save a list of strings
  Future<void> saveStringList(String key, List<String> value) async {
    await _prefs.setStringList(key, value);
  }

  // Get a list of strings
  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  // Remove a key-value pair
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  // Clear all keys
  Future<void> clear() async {
    await _prefs.clear();
  }

  //* patient
  String get patient => 'is_patient';
  set setPatient(bool value) {
    _prefs.setBool(patient, value);
  }

  bool get isPatient => _prefs.getBool(patient) ?? false;

  //* provider
  String get provider => 'is_provider';
  set setProvider(bool value) {
    _prefs.setBool(provider, value);
  }

  bool get isProvider => _prefs.getBool(provider) ?? false;
}
