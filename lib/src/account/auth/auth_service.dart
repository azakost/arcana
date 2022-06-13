import 'package:dio/dio.dart';

import '../../core.dart';

class AuthService {
  static Future<Response> requestCode(String phone, bool isCall) async {
    return await Core.post('/profile/send_validating_code', {
      "err_ne": false,
      "is_call": isCall,
      "phone": phone,
    });
  }

  static Future<Response> checkCode(String phone, String code, bool isCall) async {
    return await Core.post(
      '/profile/auth_reg',
      {
        "ava": "",
        "name": "",
        "phone": phone,
        "sms_code": int.parse(code),
        "type_id": 0,
      },
      saveToken: true,
    );
  }

  static Future<Response> getUser() async {
    return await Core.get('/profile');
  }
}
