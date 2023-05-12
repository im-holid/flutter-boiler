import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Store {
  static Future<void> write(Enum keyEnum, dynamic value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyEnum.name, value);
    return;
  }

  static Future<dynamic> read(Enum keyEnum) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(keyEnum.name) ?? '';
    if (data == '') return '';
    return jsonDecode(data);
  }

  static Future<void> remove(Enum keyEnum) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(keyEnum.name);
    return;
  }

  static Future<void> removeAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return;
  }
}
