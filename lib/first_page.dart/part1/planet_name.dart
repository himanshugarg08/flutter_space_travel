import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlanetName extends StatelessWidget {
  const PlanetName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 2200),
      curve: Curves.easeInOutCirc,
      tween: Tween<double>(begin: 1.2, end: 1.0),
      builder: (context, double value, _) {
        return Align(
          alignment: Alignment(0, -0.55 + (value - 1.0)),
          child: Opacity(
            opacity: 6.0 - 5.0 * value,
            child: Text(
              "M\nA\nR\nS",
              style: GoogleFonts.oxygen(
                  color: Colors.white,
                  fontSize: 80 * value,
                  height: 1.15 * value,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
