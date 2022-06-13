import 'package:flutter/material.dart';

import '../src/theme.dart';

class InfoBanner extends StatelessWidget {
  const InfoBanner(this.text, {this.warn = false, Key? key}) : super(key: key);
  final bool warn;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 27, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: warn ? whiteRed : whiteBlue,
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, size: 20, color: warn ? primaryRed : primaryBlue),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                height: 18 / 12,
                letterSpacing: -0.24,
                fontWeight: FontWeight.w400,
                color: warn ? primaryRed : primaryBlue,
              ),
            ),
          )
        ],
      ),
    );
  }
}
