import 'package:arcadi/components/custom_appbar.dart';
import 'package:arcadi/src/localization/source.dart';
import 'package:arcadi/src/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../icons.dart';
import '../theme.dart';

class MarkerPage extends StatelessWidget {
  const MarkerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final t = loc(context)!;
    Widget title(String text) {
      return Padding(
        padding: const EdgeInsets.only(top: 8, left: 0, right: 16, bottom: 4),
        child: Text(text, style: theme.headline5),
      );
    }

    return Scaffold(
      appBar: appbar(context, 'title'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              title(t.trends),
              InkWell(
                child: Row(
                  children: [
                    Text(t.all_time, style: theme.subtitle1!.copyWith(color: primaryBlue)),
                    const SizedBox(width: 4),
                    const Icon(CustomIcons.down, color: primaryBlue, size: 20),
                  ],
                ),
                onTap: () {},
              )
            ],
          ),
          const SizedBox(height: 16),
          const SizedBox(height: 24),
          title(t.indludes_in_profiles),
          const SizedBox(height: 16),
          Include(),
          const SizedBox(height: 24),
          title(t.guide),
          const SizedBox(height: 4),
          Text('${t.value_for_men}, 2 г.', style: theme.caption!.copyWith(fontWeight: FontWeight.w400)),
          const SizedBox(height: 13),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: bgGrey,
            ),
            child: Text(
              'desc',
              style: theme.caption!.copyWith(fontWeight: FontWeight.w400, color: black, height: 18 / 12),
            ),
          )
        ],
      ),
    );
  }
}

class Include extends StatelessWidget {
  const Include({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final profiles = context.read(dictionatyProvider).state.profiles;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(profiles.length, (index) {
        return Label(profiles[index].name, check: true);
      }),
    );
  }
}

class Label extends StatelessWidget {
  const Label(this.text, {this.check = false, Key? key}) : super(key: key);
  final String text;
  final bool check;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: check ? darkBlue : primaryBlue,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (check) const Icon(Icons.check_circle, size: 14, color: Colors.white),
          if (check) const SizedBox(width: 5),
          Text(text, style: theme.caption!.copyWith(color: Colors.white)),
        ],
      ),
    );
  }
}
