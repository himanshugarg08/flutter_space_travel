import 'package:flutter/material.dart';

class SeatClipper extends CustomClipper<Rect> {
  double height;
  SeatClipper({required this.height});

  @override
  Rect getClip(Size size) {
    Rect rect = Rect.fromPoints(const Offset(0, 0), Offset(size.width, height));
    return rect;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}
