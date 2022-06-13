import 'package:flutter/material.dart';

import '../src/theme.dart';

PreferredSize appbar(BuildContext context, String title, {bool main = false, bool shadow = true, IconData? actionIcon, Function()? onAction}) {
  return PreferredSize(
    child: Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(color: white, boxShadow: shadow ? [downShadow] : []),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (!main)
              GestureDetector(
                child: const Icon(Icons.chevron_left_rounded, color: middleGrey),
                onTap: () => Navigator.pop(context),
              ),
            Text(
              title,
              style: !main
                  ? const TextStyle(
                      color: darkGrey,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      height: 20 / 14,
                      letterSpacing: -0.15,
                    )
                  : Theme.of(context).textTheme.headline3,
            ),
            SizedBox(
              height: 24,
              width: 24,
              child: actionIcon != null
                  ? GestureDetector(
                      onTap: onAction,
                      child: Icon(actionIcon, color: primaryBlue),
                    )
                  : null,
            )
          ],
        ),
      ),
    ),
    preferredSize: const Size(double.maxFinite, 56 + 42),
  );
}
