import 'package:arcadi/src/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/account.dart';
import 'auth_service.dart';

class AuthController {
  static Future requestSMSCode(BuildContext context, String phone, TabController tab) async {
    final response = await AuthService.requestCode(trim(phone), false);
    if (response.statusCode == 200) {
      tab.animateTo(1);
    } else {
      // Alert
    }
  }

  static Future requestPhoneCode(BuildContext context, String phone, TabController tab) async {
    final response = await AuthService.requestCode(trim(phone), true);
    if (response.statusCode == 200) {
      tab.animateTo(2);
    } else {
      // Alert
    }
  }

  static Future checkCode(BuildContext context, String phone, String code, bool isCall) async {
    final response = await AuthService.checkCode(trim(phone), code, isCall);

    if (response.statusCode == 200) {
      final res = await AuthService.getUser();
      final account = Account.fromJson(res.data);
      context.read(accountProvider).state = account;
      for (final acc in account.relatives) {
        if (acc.id == account.currentUserId) {
          context.read(currentUserProvider).state = acc;
          break;
        }
      }
      Navigator.pushNamed(context, '/tabs');
    } else {
      //Alert

    }
  }

  static String trim(String raw) {
    return raw.replaceAll(' ', '').replaceAll('(', '').replaceAll(')', '');
  }
}
