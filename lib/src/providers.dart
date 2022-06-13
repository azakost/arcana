import 'package:arcadi/models/search.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/account.dart';
import '../models/dictionary.dart';

final dictionatyProvider = StateProvider<Data>((ref) => Data());
final accountProvider = StateProvider<Account>((ref) => Account());
final currentUserProvider = StateProvider<User>((ref) => User());
final searchProvider = StateProvider<List<SearchResult>>((ref) => []);
