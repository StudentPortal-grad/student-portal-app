import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalStorage {
  static late SharedPreferences prefs;
  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static dynamic getData({required String key}) => prefs.get(key);

  static Future<bool> saveData({required String key, dynamic value}) async {
    debugPrint(value.toString());
    if (value is int) return await prefs.setInt(key, value);
    if (value is bool) return await prefs.setBool(key, value);
    if (value is String) return await prefs.setString(key, value);
    if (value is Map) return await prefs.setString(key, json.encode(value));
    return await prefs.setDouble(key, value);
  }

  static Future<void> saveMap(String key, Map<String, dynamic> jsonMap) async {
    await prefs.setString(key, json.encode(jsonMap));
  }

  static Map<String, dynamic>? getMap<T>(String key) {
    final String? value = prefs.getString(key);
    if (value != null) {
      return json.decode(prefs.getString(key)!) as Map<String, dynamic>;
    } else {
      return null;
    }
  }

  static Future<bool> removeData(String key) async {
    return await prefs.remove(key);
  }
}
