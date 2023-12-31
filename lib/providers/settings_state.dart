import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsData {
  String username = '';
  String password = '';
  bool verified = false;
  bool amollaMode = false;

  SettingsData();

  SettingsData.fromJson(Map<String, dynamic> json)
    : username = json['username'] ?? '',
      password = json['password'] ?? '',
      verified= json['verified'] ?? false,
      amollaMode = json['amollaMode'] ?? false;

  Map<String,dynamic> toJSON() => {
    'username': username,
    'password': password,
    'verified': verified,
    'amollaMode': amollaMode,
  };
}

class SettingsState extends ChangeNotifier {
  final _prefs = SharedPreferences.getInstance();
  SettingsData data = SettingsData();

  Future<void> save() async {
    final prefs = await _prefs;
    prefs.setString('data', jsonEncode(data.toJSON()));
    notifyListeners();
  }

  Future<void> load() async {
    final prefs = await _prefs;
    final jsonString = prefs.getString('data') ?? '{}';
    data = SettingsData.fromJson(jsonDecode(jsonString));
    notifyListeners();
  }
}
