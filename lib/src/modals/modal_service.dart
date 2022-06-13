import 'package:dio/dio.dart';

import '../../models/account.dart';
import '../core.dart';

class ModalService {
  static Future<Response> saveUser(User user) async {
    return await Core.put('/profile', user.toJson());
  }
}
