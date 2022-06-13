import 'package:arcadi/src/theme.dart';
import 'package:flutter/material.dart';

class ModalBody extends StatelessWidget {
  const ModalBody(
    this.context, {
    required this.title,
    required this.back,
    this.children = const [],
    Key? key,
  }) : super(key: key);
  final BuildContext context;
  final String title;
  final String back;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 16, MediaQuery.of(context).viewInsets.bottom + 24),
      decoration: const BoxDecoration(
        color: white,
        boxShadow: [upShadow],
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: 4, width: 40, decoration: BoxDecoration(color: const Color(0xFFE5E5E5), borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: black, fontWeight: FontWeight.w400)),
              InkWell(
                child: Text(back, style: text.subtitle1!.copyWith(color: primaryBlue)),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          )
        ],
      ),
    );
  }
}
