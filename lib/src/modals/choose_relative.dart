import 'package:arcadi/components/modal_body.dart';
import 'package:arcadi/src/modals/modal_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../localization/source.dart';
import '../providers.dart';
import '../theme.dart';

class ChooseRelative extends HookWidget {
  const ChooseRelative({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = loc(context)!;
    final relatives = useProvider(accountProvider).state.relatives;
    final current = useProvider(currentUserProvider).state;
    return ListTileTheme(
      horizontalTitleGap: 8,
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 20,
      child: ModalBody(
        context,
        title: t.account,
        back: t.back,
        children: [
          Column(
            children: List.generate(relatives.length, (index) {
              final u = relatives[index];
              return ListTile(
                selected: u.id == current.id,
                leading: Image.asset('assets/img/${u.gender ? 'man' : 'woman'}_active.png', height: 24),
                title: Text(u.name),
                selectedTileColor: bgGrey,
                onTap: () => ModalController.chooseUser(context, u),
              );
            }),
          ),
          ListTile(
            leading: const Icon(Icons.add, color: primaryRed),
            title: Text(t.add_account),
            onTap: () {
              Navigator.pop(context);
              ModalController.addRelative(context);
            },
          )
        ],
      ),
    );
  }
}
