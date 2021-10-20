import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ZoneList extends StatelessWidget {
  const ZoneList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 108,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return TweenAnimationBuilder(
                  duration: Duration(milliseconds: 400 * (1 + index)),
                  curve: Curves.easeInOut,
                  tween: Tween<double>(begin: 1.0, end: 0.0),
                  builder: (context, double value, child) {
                    return Transform.translate(
                        offset: Offset(40 * value, 0), child: child!);
                  },
                  child: ZoneWidget(index: index),
                );
              }),
        ),
      ),
    );
  }
}

class ZoneWidget extends StatelessWidget {
  final int index;

  const ZoneWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        height: 108,
        width: 90,
        decoration: BoxDecoration(
            border: Border.all(width: 0.2, color: Colors.white),
            borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Zone ${index + 1}",
                style: GoogleFonts.oxygen(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w100,
                ),
                textAlign: TextAlign.start,
              ),
              Text(
                "${index + 29}m",
                style: GoogleFonts.oxygen(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
