import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/custom_appbar.dart';
import '../icons.dart';
import '../localization/source.dart';
import '../modals/modal_controller.dart';
import '../providers.dart';
import '../theme.dart';
import 'account_controller.dart';

class AccountView extends StatelessWidget {
  const AccountView(this.settings, {Key? key}) : super(key: key);
  final AccountController settings;

  @override
  Widget build(BuildContext context) {
    final t = loc(context)!;
    return Scaffold(
      appBar: appbar(
        context,
        t.account,
        main: true,
        actionIcon: Icons.logout,
        onAction: () => AccountController.logout(context),
      ),
      body: ListView(
        children: [
          Padding(padding: const EdgeInsets.all(16), child: const UserProfile()),
          AccountItem(
            title: t.change_phone,
            icon: Icons.phone_android,
            onTap: () => AccountController.changePhone(context),
          ),
          const Divider(height: 0),
          AccountItem(
            title: t.change_lang,
            icon: Icons.language,
            onTap: () => ModalController.changeLanguage(context, settings),
          ),
          const Divider(height: 0),
          AccountItem(
            title: t.privacy_policy,
            icon: Icons.shield,
            onTap: () => AccountController.privacyPolicy(),
          ),
          const Divider(height: 0),
          const SizedBox(height: 24),
          AccountItem(
            title: t.change_account,
            withChevron: false,
            icon: CustomIcons.family,
            onTap: () => ModalController.chooseRelative(context),
          ),
          AccountItem(
            title: t.add_account,
            withChevron: false,
            icon: Icons.person_add,
            onTap: () => ModalController.addRelative(context),
          ),
        ],
      ),
    );
  }
}

class UserProfile extends HookWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final user = useProvider(currentUserProvider).state;
    final t = loc(context)!;
    return Row(
      children: [
        Image.asset('assets/img/${user.gender ? 'man' : 'woman'}_active.png', height: 60),
        const SizedBox(width: 16),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.name, style: theme.subtitle1),
            const SizedBox(height: 4),
            Text(
              t.age(user.age),
              style: const TextStyle(
                fontSize: 12,
                height: 14 / 12,
                letterSpacing: -0.24,
                fontWeight: FontWeight.w400,
                color: middleGrey,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class AccountItem extends StatelessWidget {
  const AccountItem({
    required this.title,
    required this.icon,
    required this.onTap,
    this.withChevron = true,
    Key? key,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final Function() onTap;
  final bool withChevron;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      minLeadingWidth: 20,
      horizontalTitleGap: 8,
      contentPadding: const EdgeInsets.fromLTRB(16, 2, 16, 2),
      title: Text(title, style: Theme.of(context).textTheme.headline5),
      leading: Icon(icon, color: primaryBlue),
      trailing: withChevron ? const Icon(Icons.chevron_right) : null,
    );
  }
}
