import 'dart:math';

import 'package:arcadi/src/modals/add_marker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/account.dart';
import '../account/account_controller.dart';
import '../providers.dart';
import 'add_relative.dart';
import 'add_self.dart';
import 'ask_to_add.dart';
import 'change_language.dart';
import 'choose_relative.dart';
import 'modal_service.dart';

class ModalController {
  static checkIfHasData(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) async {
        final currentUser = context.read(currentUserProvider).state;
        if (currentUser.height == 0 || currentUser.weight == 0 || currentUser.age == 0) {
          await Future.delayed(const Duration(seconds: 3));
          addData(context);
        }
      },
    );
  }

  static changeLanguage(BuildContext context, AccountController settings) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ChangeLanguage(settings);
      },
    );
  }

  static askToAdd(BuildContext context) {
    showModalBottomSheet(
      barrierColor: Colors.black.withOpacity(0.6),
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      builder: (_) {
        return AskToAdd();
      },
    ).whenComplete(() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('inform', true);
    });
  }

  static addData(BuildContext context) {
    showModalBottomSheet(
      barrierColor: Colors.black.withOpacity(0.6),
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      builder: (_) {
        return AddSelf();
      },
    ).whenComplete(() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final isInformed = prefs.getBool('inform') ?? false;
      if (!isInformed) {
        await Future.delayed(const Duration(seconds: 3));
        ModalController.askToAdd(context);
      }
    });
  }

  static addRelative(BuildContext context) {
    showModalBottomSheet(
      barrierColor: Colors.black.withOpacity(0.6),
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      builder: (_) {
        return AddRelative();
      },
    );
  }

  static chooseRelative(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ChooseRelative();
      },
    );
  }

  static addMarker(BuildContext context, Recomended marker, bool isMarker) {
    showModalBottomSheet(
      barrierColor: Colors.black.withOpacity(0.6),
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      builder: (_) {
        return AddMarker(marker, isMarker: isMarker);
      },
    ).whenComplete(() {
      context.read(currentSearchProvider).state = [];
    });
  }

  static addAnalysis(BuildContext context) {}

  static Future saveUser(BuildContext context, User user, {bool addToList = false}) async {
    await ModalService.saveUser(user);

    if (addToList) {
      // TEMP
      // user.id = response.data['id'] as int; TODO: uncomment
      var rng = Random();
      var id = 0;
      for (var i = 0; i < 10; i++) {
        id = rng.nextInt(100);
      }
      // TEMP

      user.id = id;
      context.read(currentUserProvider).state = user;
      context.read(accountProvider).state.relatives.add(user);
    }
    Navigator.pop(context);
  }

  static Future chooseUser(BuildContext context, User user) async {
    context.read(currentUserProvider).state = user;
    Navigator.pop(context);
  }
}
