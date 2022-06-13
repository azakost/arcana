import 'dart:async';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

String baseURL = 'https://e752acb8-e206-44fc-a5c3-47afa0455002.mock.pstmn.io';
final dio = Dio(BaseOptions(connectTimeout: 10000, baseUrl: baseURL));
final opt = Options(validateStatus: (status) => status! < 503);

class Core {
  static Future<Response> get(String path) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      opt.headers = {"Authorization": token};
    }
    final res = await dio.get(path, options: opt);
    return res;
  }

  static Future<Response> post(String path, dynamic data, {bool saveToken = false}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      opt.headers = {"Authorization": token};
    }
    final res = await dio.post(path, data: data, options: opt);
    if (saveToken) {
      prefs.setString('token', res.data['token']);
    }
    return res;
  }

  static Future<Response> put(String path, dynamic data, {bool saveToken = false}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      opt.headers = {"Authorization": token};
    }
    final res = await dio.put(path, data: data, options: opt);
    if (saveToken) {
      prefs.setString('token', res.data['token']);
    }
    return res;
  }
}
