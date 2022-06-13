import 'package:flutter/material.dart';

import '../src/theme.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({required this.icon, required this.label, required this.child, Key? key}) : super(key: key);
  final IconData icon;
  final String label;
  final TextField child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              Icon(icon, size: 14, color: middleGrey),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 18 / 14,
                  letterSpacing: -0.15,
                  color: darkGrey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
