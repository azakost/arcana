import 'package:arcadi/components/modal_body.dart';
import 'package:flutter/material.dart';

import '../localization/source.dart';
import 'modal_controller.dart';

class AskToAdd extends StatelessWidget {
  const AskToAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = loc(context)!;
    final theme = Theme.of(context).textTheme;
    return ModalBody(
      context,
      title: t.add_family,
      back: t.back,
      children: [
        Text(t.ask_to_add, style: theme.bodyText2),
        const SizedBox(height: 24),
        ElevatedButton(
          child: Text(t.add_account),
          onPressed: () {
            Navigator.pop(context);
            ModalController.addRelative(context);
          },
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          child: Text(t.skip),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
