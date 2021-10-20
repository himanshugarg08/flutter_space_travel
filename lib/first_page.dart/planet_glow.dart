import 'package:flutter/material.dart';

class PlanetGlow extends StatelessWidget {
  final double begin;
  const PlanetGlow({
    Key? key,
    required this.begin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        duration: const Duration(milliseconds: 5000),
        curve: Curves.easeInOut,
        tween: Tween<double>(begin: begin, end: 0.5),
        builder: (context, double value, child) {
          return Opacity(
            opacity: value,
            child: Align(
              alignment: const Alignment(0, 1.5),
              child: Transform.scale(
                scale: 1.05,
                child: Container(
                  height: 450,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffDA6723),
                        spreadRadius: 50,
                        blurRadius: 50,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
