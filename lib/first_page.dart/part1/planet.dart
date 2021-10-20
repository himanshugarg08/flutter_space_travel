import 'dart:math';

import 'package:flutter/material.dart';

class Planet extends StatelessWidget {
  final VoidCallback afterEnd;
  final double begin;

  const Planet({Key? key, required this.afterEnd, required this.begin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 2500),
      curve: Curves.easeInOutCirc,
      tween: Tween<double>(begin: begin, end: 1.0),
      onEnd: afterEnd,
      builder: (context, double value, child) {
        return Align(
          alignment: Alignment(0, value),
          child: Transform.rotate(
            angle: pi / 2.5 * value,
            child: Transform.translate(
              offset: const Offset(4, 0),
              child: Transform.scale(
                scale: 5 - value,
                child: child,
              ),
            ),
          ),
        );
      },
      child: Image.asset('assets/mars.png'),
    );
  }
}
