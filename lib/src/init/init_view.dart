import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../localization/source.dart';
import '../theme.dart';
import 'init_controller.dart';

class InitView extends StatefulWidget {
  const InitView({Key? key}) : super(key: key);

  @override
  State<InitView> createState() => _InitViewState();
}

class _InitViewState extends State<InitView> {
  @override
  void initState() {
    InitController.initApp(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final t = loc(context)!;
    return Container(
      decoration: const BoxDecoration(gradient: mainGradient),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0x00000000),
          body: Column(
            children: [
              const Spacer(),
              const CupertinoActivityIndicator(radius: 14),
              const SizedBox(height: 24),
              Text(t.appTitle, style: Theme.of(context).textTheme.headline4!.copyWith(color: white)),
              const SizedBox(height: 24, width: double.maxFinite),
            ],
          ),
        ),
      ),
    );
  }
}
