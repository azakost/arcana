import 'package:arcadi/components/profile_card.dart';
import 'package:arcadi/src/account/account_view.dart';
import 'package:arcadi/src/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/custom_appbar.dart';
import '../localization/source.dart';

class Health extends HookWidget {
  const Health({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = loc(context)!;
    final profiles = context.read(dictionatyProvider).state.profiles;
    final cp = context.read(currentUserProvider).state.chosenProfilesIds;
    final rp = context.read(currentUserProvider).state.recomendedProfilesIds;
    final pa = context.read(currentUserProvider).state.passedAnalyzes;
    final pm = context.read(currentUserProvider).state.passedMarkers;
    final theme = Theme.of(context).textTheme;
    Widget title(String text) {
      return Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 4),
        child: Text(text, style: theme.headline5),
      );
    }

    return Scaffold(
      appBar: appbar(context, t.health, main: true),
      body: ListView(
        children: [
          title(t.health_profile),
          Padding(
            padding: const EdgeInsets.all(16),
            child: UserProfile(),
          ),
          ...List.generate(cp.length, (i) {
            for (var p in profiles) {
              if (cp[i] == p.id) {
                // Счет сданных маркеров
                int count = 0;
                for (var x in p.markersIds) {
                  for (var z in pm) {
                    if (z.id == x) {
                      count++;
                    }
                  }
                }

                // Счет сданных анализов
                for (var y in p.analyzesIds) {
                  for (var g in pa) {
                    if (g.id == y) {
                      count++;
                    }
                  }
                }

                return ProfileCard(
                  title: p.name,
                  bottom: 'Сданы анализы $count из ${p.markersIds.length + p.analyzesIds.length}',
                  colors: p.colors,
                  image: p.image,
                  onTap: () {},
                );
              }
            }
            return const SizedBox();
          }),
          const SizedBox(height: 12),
          title(t.recommended),
          ...List.generate(rp.length, (i) {
            for (var p in profiles) {
              if (rp[i] == p.id) {
                return ProfileCard(
                  title: p.name,
                  bottom: 'Сданы анализы ',
                  colors: p.colors,
                  image: p.image,
                  onTap: () {},
                );
              }
            }
            return const SizedBox();
          }),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
