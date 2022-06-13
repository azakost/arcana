import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    this.isChosen = false,
    required this.title,
    required this.bottom,
    required this.colors,
    required this.image,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final bool isChosen;
  final String title;
  final String bottom;
  final List<String> colors;
  final String image;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    var cols = [];
    if (colors.length < 2) {
      cols = ['#2B5876', '#4E4376'];
    } else {
      cols = colors;
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        width: double.maxFinite,
        height: 124,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Hex.fromHex(cols[0]), Hex.fromHex(cols[1])],
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [BoxShadow(blurRadius: 16, color: Color(0x20000000))],
        ),
        child: Stack(
          children: [
            Positioned(
              child: CachedNetworkImage(
                imageUrl: image,
                height: 100,
              ),
              right: -20,
              bottom: -5,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isChosen ? 'Вы выбрали:' : 'Профиль',
                          style: const TextStyle(
                            fontSize: 12,
                            height: 14 / 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFEBEBEB),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 24,
                            height: 30 / 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          bottom,
                          style: const TextStyle(
                            fontSize: 12,
                            height: 14 / 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFF8F8F8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 95),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension Hex on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
