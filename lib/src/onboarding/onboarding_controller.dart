import 'package:flutter/material.dart';

class OnboardingController {
  static register(BuildContext context) {
    Navigator.pushNamed(context, '/auth');
  }

  static enter(BuildContext context) {}
  static demo(BuildContext context) {}
}
