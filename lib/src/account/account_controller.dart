import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'account_service.dart';

class AccountController with ChangeNotifier {
  AccountController(this._settingsService);
  final AccountService _settingsService;

  late Locale _locale;
  Locale get localeMode => _locale;

  Future<void> loadSettings() async {
    _locale = await _settingsService.setLocale();
    notifyListeners();
  }

  Future<void> updateLocale(String? newLocale) async {
    if (Locale(newLocale!) == _locale) return;
    _locale = Locale(newLocale);
    notifyListeners();
    await _settingsService.storeLocale(newLocale);
  }

  static changePhone(BuildContext context) {}

  static privacyPolicy() {}

  static logout(BuildContext context) {}
}
