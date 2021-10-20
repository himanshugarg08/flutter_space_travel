import 'package:flutter/material.dart';

class CustomFadeAnimatedWidget extends StatefulWidget {
  final Widget child;
  final int delay;
  const CustomFadeAnimatedWidget(
      {Key? key, required this.child, this.delay = 0})
      : super(key: key);

  @override
  State<CustomFadeAnimatedWidget> createState() =>
      _CustomFadeAnimatedWidgetState();
}

class _CustomFadeAnimatedWidgetState extends State<CustomFadeAnimatedWidget> {
  bool startAnimation = false;

  @override
  void initState() {
    Future.delayed(
        widget.delay == 0
            ? Duration.zero
            : Duration(milliseconds: widget.delay), () {
      if (mounted) {
        setState(() {
          startAnimation = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return startAnimation
        ? TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            builder: (context, double value, _) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                    offset: Offset(0, -20 * (1 - value)), child: widget.child),
              );
            })
        : const SizedBox();
  }
}
