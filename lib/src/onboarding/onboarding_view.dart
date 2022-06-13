import 'package:flutter/material.dart';

import '../localization/source.dart';
import '../theme.dart';
import 'onboarding_controller.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = loc(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            Carousel(
              pages: [
                CarouselPage(image: 'assets/img/point1.png', title: t.point_1, subtitle: t.point_1_desc),
                CarouselPage(image: 'assets/img/point2.png', title: t.point_2, subtitle: t.point_2_desc),
                CarouselPage(image: 'assets/img/point3.png', title: t.point_3, subtitle: t.point_3_desc),
              ],
            ),
            const Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () => OnboardingController.register(context),
                    child: Text(t.auth),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () => OnboardingController.enter(context),
                    child: Text(t.demo),
                  ),
                  const SizedBox(height: 8),
                  // OutlinedButton(
                  //   onPressed: () => OnboardingController.demo(context),
                  //   child: Text(t.demo),
                  //   style: ButtonStyle(side: MaterialStateProperty.all(BorderSide.none)),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Carousel extends StatefulWidget {
  const Carousel({required this.pages, Key? key}) : super(key: key);
  final List<CarouselPage> pages;

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> with SingleTickerProviderStateMixin {
  TabController? _controller;
  int i = 0;

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    _controller!.addListener(() {
      setState(() => i = _controller!.index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    Widget point(int number, String title, String desc, String image) {
      return Column(
        children: [
          Image.asset(image, height: 176),
          const SizedBox(height: 37),
          Text(title, textAlign: TextAlign.center, style: text.headline4),
          const SizedBox(height: 16),
          Text(desc, textAlign: TextAlign.center, style: text.bodyText1),
        ],
      );
    }

    Widget dot(int n) {
      return GestureDetector(
        onTap: () => _controller!.animateTo(n),
        child: Container(
          height: 8,
          width: i == n ? 16 : 8,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: i == n ? primaryBlue : alphaBlack,
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 337,
          child: TabBarView(
            controller: _controller,
            children: List.generate(
              widget.pages.length,
              (index) {
                final p = widget.pages[index];
                return point(index, p.title, p.subtitle, p.image);
              },
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(mainAxisSize: MainAxisSize.min, children: List.generate(widget.pages.length, (i) => dot(i))),
      ],
    );
  }
}

class CarouselPage {
  const CarouselPage({
    required this.image,
    required this.title,
    required this.subtitle,
  });
  final String image;
  final String title;
  final String subtitle;
}
