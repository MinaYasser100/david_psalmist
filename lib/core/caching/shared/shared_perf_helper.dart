// shared_pref_helper.dart
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  final SharedPreferences _prefs;

  SharedPrefHelper._internal(this._prefs);

  static Future<SharedPrefHelper> getInstance() async {
    final prefs = await SharedPreferences.getInstance();
    return SharedPrefHelper._internal(prefs);
  }

  // حفظ String
  Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  // استرجاع String
  String? getString(String key) {
    return _prefs.getString(key);
  }

  // حفظ int
  Future<void> saveInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  // استرجاع int
  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  // حفظ bool
  Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  // استرجاع bool
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  // حفظ double
  Future<void> saveDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  // استرجاع double
  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  // حفظ List<String>
  Future<void> saveStringList(String key, List<String> value) async {
    await _prefs.setStringList(key, value);
  }

  // استرجاع List<String>
  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  // حذف قيمة بناءً على المفتاح
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  // التحقق مما إذا كان المفتاح موجود
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  // مسح كل البيانات
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
