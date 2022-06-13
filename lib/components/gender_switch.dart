import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../src/icons.dart';
import '../src/theme.dart';

final genderProvider = StateProvider<bool>((ref) => true);

class GenderSwitch extends HookWidget {
  const GenderSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gender = useProvider(genderProvider).state;
    return Container(
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [cardShadow],
      ),
      height: 44,
      width: 110,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.read(genderProvider).state = true,
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: gender ? primaryBlue : Colors.white,
              ),
              height: 28,
              width: 47,
              padding: const EdgeInsets.all(2),
              child: Row(
                children: [
                  Icon(
                    CustomIcons.male,
                    size: 20,
                    color: gender ? Colors.white : primaryBlue,
                  ),
                  Text(
                    'М',
                    style: TextStyle(
                      color: gender ? Colors.white : darkGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 20 / 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => context.read(genderProvider).state = false,
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: gender ? Colors.white : primaryBlue,
              ),
              height: 28,
              width: 47,
              padding: const EdgeInsets.all(2),
              child: Row(
                children: [
                  Icon(CustomIcons.female, size: 20, color: gender ? primaryBlue : Colors.white),
                  Text(
                    'Ж',
                    style: TextStyle(
                      color: gender ? darkGrey : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 20 / 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
