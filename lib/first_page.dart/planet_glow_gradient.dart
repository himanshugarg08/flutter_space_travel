import 'package:flutter/material.dart';

class PlanetGlowGradient extends StatelessWidget {
  final double begin;
  const PlanetGlowGradient({
    Key? key,
    required this.begin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        duration: const Duration(milliseconds: 5000),
        curve: Curves.easeInOut,
        tween: Tween<double>(begin: begin, end: 0.6),
        builder: (context, double value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: const Offset(0, 200),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                      radius: 1.4,
                      colors: [Color(0xffDA6723), Colors.transparent]),
                ),
              ),
            ),
          );
        });
  }
}
