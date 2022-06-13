import 'package:arcadi/components/custom_appbar.dart';
import 'package:arcadi/components/custom_lt.dart';
import 'package:arcadi/components/info_banner.dart';
import 'package:arcadi/src/localization/source.dart';
import 'package:flutter/material.dart';

import '../icons.dart';
import '../theme.dart';
import 'marker_page.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = loc(context)!;
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: appbar(context, 'analysis'),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        children: [
          const SizedBox(height: 16),
          InfoBanner(t.smth_wrong, warn: true),
          const SizedBox(height: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(2, (index) {
              return CustomListTile(
                leading: Icon(CustomIcons.info, color: primaryRed),
                title: 'sdsd',
                subtitle: 'sds',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text('200 мк', style: theme.caption)],
                ),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MarkerPage())),
              );
            }),
          )
        ],
      ),
    );
  }
}
