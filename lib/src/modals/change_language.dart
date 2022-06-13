import 'package:arcadi/components/modal_body.dart';
import 'package:flutter/material.dart';

import '../account/account_controller.dart';
import '../localization/source.dart';

class ChangeLanguage extends StatelessWidget {
  const ChangeLanguage(this.settings, {Key? key}) : super(key: key);
  final AccountController settings;
  @override
  Widget build(BuildContext context) {
    final t = loc(context)!;
    return ListTileTheme(
      dense: true,
      contentPadding: EdgeInsets.zero,
      minVerticalPadding: 0,
      horizontalTitleGap: 0,
      child: ModalBody(
        context,
        title: t.change_lang,
        back: t.back,
        children: [
          ListTile(
            title: const Text('По-русски'),
            onTap: () {
              Navigator.pop(context);
              settings.updateLocale('ru');
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Қазақша'),
            onTap: () {
              Navigator.pop(context);
              settings.updateLocale('kk');
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('In English'),
            onTap: () {
              Navigator.pop(context);
              settings.updateLocale('en');
            },
          ),
        ],
      ),
    );
  }
}
