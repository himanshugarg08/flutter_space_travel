import 'package:flutter/material.dart';

class LocationMark extends StatelessWidget {
  final double x;
  final double y;
  final int milliseconds;
  final bool withAnimation;

  const LocationMark({
    Key? key,
    required this.x,
    required this.y,
    required this.milliseconds,
    this.withAnimation = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        duration: Duration(milliseconds: milliseconds),
        curve: Curves.easeOut,
        builder: (context, value, _) {
          return Stack(
            children: [
              Opacity(
                opacity: value,
                child: Align(
                  alignment: Alignment(x, y),
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: Stack(
                      children: [
                        if (withAnimation)
                          Opacity(
                            opacity: 1 - value,
                            child: Center(
                              child: Container(
                                height: 80 * value,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white.withOpacity(0.5)),
                                    color: Colors.transparent,
                                    shape: BoxShape.circle),
                              ),
                            ),
                          ),
                        Center(
                          child: Container(
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                shape: BoxShape.circle),
                          ),
                        ),
                        Center(
                          child: Container(
                            height: 10,
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
