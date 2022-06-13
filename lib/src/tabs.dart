import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'account/account_controller.dart';
import 'account/account_view.dart';
import 'analyzes/analyzes_view.dart';
import 'health/health_view.dart';
import 'icons.dart';
import 'localization/source.dart';
import 'modals/modal_controller.dart';
import 'providers.dart';
import 'theme.dart';

class Tabs extends StatefulWidget {
  const Tabs(this.settings, {Key? key}) : super(key: key);
  final AccountController settings;

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  TabController? _controller;

  int current = 0;
  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    ModalController.checkIfHasData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final t = loc(context)!;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: TabBarView(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [const Analyzes(), const Health(), AccountView(widget.settings)],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [upShadow],
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          ),
          height: 88 + 16,
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Tab(0, current: current, title: t.analysis, icon: CustomIcons.probe, onTap: () {
                  _controller!.animateTo(0);
                  setState(() => current = 0);
                }),
                Tab(1, current: current, title: t.health, icon: CustomIcons.graph, onTap: () {
                  _controller!.animateTo(1);
                  setState(() => current = 1);
                }),
                Tab(
                  2,
                  current: current,
                  title: t.account,
                  image: true,
                  onTap: () {
                    _controller!.animateTo(2);
                    setState(() => current = 2);
                  },
                  onLongPress: () => ModalController.chooseRelative(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Tab extends HookWidget {
  const Tab(
    this.index, {
    required this.current,
    required this.onTap,
    required this.title,
    this.icon,
    this.image = false,
    this.onLongPress,
    Key? key,
  }) : super(key: key);
  final int current;
  final int index;
  final IconData? icon;
  final String title;
  final bool image;
  final Function() onTap;
  final Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    var col = index == current ? primaryBlue : middleGrey;
    var weight = index == current ? FontWeight.w700 : FontWeight.w500;
    var img = index == current ? '_active' : '';
    final currentUser = useProvider(currentUserProvider).state;
    var gender = currentUser.gender ? 'man' : 'woman';
    return Expanded(
      child: GestureDetector(
        onLongPress: onLongPress,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              !image ? Icon(icon, size: 28, color: col) : Image.asset('assets/img/$gender$img.png', height: 28),
              const SizedBox(height: 2),
              Text(title, style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: weight, color: col)),
            ],
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
