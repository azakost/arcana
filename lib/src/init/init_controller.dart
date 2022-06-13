import 'package:flutter/material.dart';

import 'init_service.dart';

class InitController {
  static Future initApp(BuildContext context) async {
    final response = await InitService.getDictionary(context);
    if (response.statusCode == 200) {
      Navigator.pushNamed(context, '/onboarding');
    } else {
      // Alert
    }
  }
}
