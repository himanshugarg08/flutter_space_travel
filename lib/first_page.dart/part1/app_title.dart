import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        duration: const Duration(milliseconds: 2800),
        curve: Curves.easeInOutCirc,
        tween: Tween<double>(begin: 0.0, end: 0.5),
        builder: (context, double value, child) {
          return Opacity(
            opacity: value,
            child: SizedBox(
              height: 120,
              width: double.infinity,
              child: Center(
                child: Text(
                  "SPACE-X",
                  style: GoogleFonts.oxygen(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 28 * value,
                      fontWeight: FontWeight.w100),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        });
  }
}
