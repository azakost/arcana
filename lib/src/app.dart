import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'account/account_controller.dart';
import 'account/auth/auth_view.dart';
import 'init/init_view.dart';
import 'onboarding/onboarding_view.dart';
import 'tabs.dart';
import 'theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.accountController}) : super(key: key);

  final AccountController accountController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: accountController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          restorationScopeId: 'app',
          localizationsDelegates: const [
            // AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ru'), Locale('en'), Locale('kk')],
          locale: accountController.localeMode,
          theme: lightTheme,
          initialRoute: '/init',
          routes: {
            '/init': (context) => InitView(),
            '/onboarding': (context) => Onboarding(),
            '/auth': (context) => Auth(),
            '/tabs': (context) => Tabs(accountController),
          },
        );
      },
    );
  }
}
