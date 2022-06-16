import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

SpUtils spUtils = SpUtils();

class SpUtils {
  SpUtils() {
    getInstance();
  }

  SpUtils._();

  static SpUtils? _instance;
  static SharedPreferences? prefs;

  static Future<SpUtils> get instance async {
    return getInstance();
  }

  Future<void> _init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<SpUtils> getInstance() async {
    if (_instance == null) {
      _instance = SpUtils._();
      await _instance!._init();
    }
    return _instance!;
  }

  Future<void> putBool(String key, bool value) async {
    await prefs!.setBool(key, value);
  }

  bool? getBool(String key) {
    return prefs?.getBool(key);
  }

  Future<void> putString(String key, String value) async {
    await prefs!.setString(key, value);
  }

  String? getString(String key) {
    return prefs?.getString(key);
  }

  Future<void> putInt(String key, int value) async {
    await prefs!.setInt(key, value);
  }

  int? getInt(String key) {
    return prefs?.getInt(key);
  }

  void removeKey(String key) {
    prefs!.remove(key);
  }

  Future<bool> clear() async {
    return prefs!.clear();
  }
}
