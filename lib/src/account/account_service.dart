import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountService {
  Future<Locale> setLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return Locale(prefs.getString('locale') ?? 'ru');
  }

  Future storeLocale(String loc) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', loc);
  }
}
