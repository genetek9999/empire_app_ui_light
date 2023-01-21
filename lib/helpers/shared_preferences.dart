import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<String> getString(String key) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      return preferences.getString(key) ?? "";
    } catch (e) {
      return "";
    }
  }

  static void setString(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  static void removeValues(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }
}
