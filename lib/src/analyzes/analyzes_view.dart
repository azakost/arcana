import 'package:arcadi/models/account.dart';
import 'package:arcadi/models/dictionary.dart';
import 'package:arcadi/src/analyzes/marker_page.dart';
import 'package:arcadi/src/modals/add_marker.dart';
import 'package:arcadi/src/modals/modal_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/custom_appbar.dart';
import '../../components/custom_lt.dart';
import '../icons.dart';
import '../localization/source.dart';
import '../providers.dart';
import '../theme.dart';
import 'analysis_page.dart';

class Analyzes extends StatelessWidget {
  const Analyzes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = loc(context)!;
    final text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: appbar(
        context,
        t.analysis,
        main: true,
        actionIcon: Icons.add,
        onAction: () => ModalController.addMarker(context, Recomended(), true),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 92),
        children: [
          Text(t.what_to_pass, style: text.headline6),
          const WhatToPass(),
          const SizedBox(height: 24),
          Text(t.your_analysis, style: text.headline6),
          const Passed(),
        ],
      ),
    );
  }
}

class WhatToPass extends HookWidget {
  const WhatToPass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = useProvider(currentUserProvider).state;
    final dic = context.read(dictionatyProvider).state;
    final analyzes = currentUser.recomendedAnalyzes;
    final markers = currentUser.recomendedMarkers;
    final t = loc(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // recomended analyzes
        Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(analyzes.length, (index) {
            final a = analyzes[index];
            Analyze found = Analyze();
            for (final x in dic.analyzes) {
              if (x.id == a.id) {
                found = x;
                break;
              }
            }

            return CustomListTile(
              leading: Icon(CustomIcons.pill, color: primaryBlue),
              title: found.name,
              subtitle: t.until(a.dueDate),
              trailing: const Icon(Icons.add),
              onTap: () {
                for (final x in dic.analyzes) {
                  if (x.id == a.id) {
                    context.read(currentAnalysisProvider).state = x.markers;
                  }
                }
                ModalController.addMarker(context, a, false);
              },
            );
          }),
        ),

        // recomended markers
        Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(markers.length, (index) {
            final m = markers[index];
            Marker found = Marker();
            for (final x in dic.markers) {
              if (x.id == m.id) {
                found = x;
                break;
              }
            }
            return CustomListTile(
              leading: Icon(CustomIcons.pill, color: primaryBlue),
              title: found.name,
              subtitle: t.until(m.dueDate),
              trailing: const Icon(Icons.add),
              onTap: () => ModalController.addMarker(context, m, true),
            );
          }),
        )
      ],
    );
  }
}

class Passed extends HookWidget {
  const Passed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = useProvider(currentUserProvider).state;
    final dic = context.read(dictionatyProvider).state;
    final analyzes = currentUser.passedAnalyzes;
    final markers = currentUser.passedMarkers;
    final theme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // passed analyzes
        Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(analyzes.length, (index) {
            final a = analyzes[index];
            Analyze found = Analyze();
            for (final x in dic.analyzes) {
              if (x.id == a.id) {
                found = x;
                break;
              }
            }
            return CustomListTile(
              leading: Icon(CustomIcons.check, color: darkBlue),
              title: found.name,
              subtitle: a.passDate,
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AnalysisPage())),
            );
          }),
        ),

        // passed markers
        Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(markers.length, (index) {
            final m = markers[index];
            Marker found = Marker();
            for (final x in dic.markers) {
              if (x.id == m.id) {
                found = x;
                break;
              }
            }
            return CustomListTile(
              leading: Icon(CustomIcons.info, color: primaryRed),
              title: found.name,
              subtitle: m.passDate,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [Text('${m.value} ${found.unit}', style: theme.caption)],
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MarkerPage())),
            );
          }),
        )
      ],
    );
  }
}
