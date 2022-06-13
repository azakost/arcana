import 'dart:convert';

import 'package:arcadi/models/search.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/dictionary.dart';
import '../core.dart';
import '../providers.dart';

class InitService {
  static Future<Response> getDictionary(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final hash = prefs.getString('hash') ?? '';
    final response = await Core.get('/dic?hs=$hash');
    if (response.statusCode == 200) {
      await prefs.setString('hash', response.data['hs']);
      Data dic;
      if (response.data['data'] != null) {
        await prefs.setString('dictionary', json.encode(response.data['data']));
        dic = Data.fromJson(response.data['data']);
      } else {
        dic = Data.fromJson(json.decode(prefs.getString('dictionary') ?? ''));
      }
      context.read(dictionatyProvider).state = dic;
      final searchAnalyzes = SearchResult.convertAnalyzes(dic.analyzes);
      final searchMarkers = SearchResult.convertMarkers(dic.markers);
      var search = List<SearchResult>.from(searchMarkers)..addAll(searchAnalyzes);
      search.sort((a, b) => a.name.compareTo(b.name));
      context.read(searchProvider).state = search;
    }
    return response;
  }
}
