import 'package:flutter/material.dart';

import '../src/theme.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    required this.leading,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.trailing,
    Key? key,
  }) : super(key: key);

  final Widget leading;
  final String title;
  final Function() onTap;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [cardShadow],
        color: white,
      ),
      child: ListTile(
        onTap: onTap,
        horizontalTitleGap: 8,
        minLeadingWidth: 24,
        leading: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: leading,
        ),
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle!, style: Theme.of(context).textTheme.subtitle2) : null,
        trailing: trailing,
      ),
    );
  }
}
