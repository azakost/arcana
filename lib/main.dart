import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'src/account/account_controller.dart';
import 'src/account/account_service.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final accountController = AccountController(AccountService());
  await accountController.loadSettings();
  runApp(ProviderScope(child: MyApp(accountController: accountController)));
}
