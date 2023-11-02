import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<bool> saveSharedPrefs<T>(
      String key, SharedPrefsType type, T value) async {
    final prefs = await _prefs;
    switch (type) {
      case SharedPrefsType.boolean:
        return prefs.setBool(key, value as bool);
      case SharedPrefsType.double:
        return prefs.setDouble(key, value as double);
      case SharedPrefsType.integer:
        return prefs.setInt(key, value as int);
      case SharedPrefsType.stringList:
        return prefs.setStringList(key, value as List<String>);
      case SharedPrefsType.string:
        return prefs.setString(key, value as String);
      default:
        throw TypeError();
    }
  }

  static Future<dynamic> readSharedPrefs(
      String key, SharedPrefsType type) async {
    final prefs = await _prefs;
    switch (type) {
      case SharedPrefsType.boolean:
        return prefs.getBool(key);
      case SharedPrefsType.double:
        return prefs.getDouble(key);
      case SharedPrefsType.integer:
        return prefs.getInt(key);
      case SharedPrefsType.stringList:
        return prefs.getStringList(key);
      case SharedPrefsType.string:
        return prefs.getString(key);
      default:
        throw TypeError();
    }
  }

  static Future<bool> updateSharedPrefs<T>(
          String key, T value, SharedPrefsType type) async =>
      await SharedPrefs.saveSharedPrefs(key, type, value);

  static Future<bool> deleteSharedPrefs(String key) async {
    final prefs = await _prefs;
    return await prefs.remove(key);
  }

  static Future<bool> isExist(String key) async {
    final prefs = await _prefs;
    return prefs.containsKey(key);
  }
}

enum SharedPrefsType { boolean, double, integer, stringList, string }

//bool, double, int, stringList, int
