import 'package:flutter/material.dart';
import 'package:mars/second_page/seat.dart';
import 'package:mars/second_page/seat_clipper.dart';

class SeatColumn extends StatelessWidget {
  final double animationValue;
  final Size size;
  final Function(bool) updateParameter;
  const SeatColumn({
    Key? key,
    required this.animationValue,
    required this.size,
    required this.updateParameter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 1.0 - animationValue,
      child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 2400),
          tween: Tween<double>(begin: 0.0, end: 1.0),
          curve: Curves.easeInOut,
          builder: (context, double value, _) {
            return ClipRect(
              clipper: SeatClipper(height: size.height * value),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 18,
                        itemBuilder: (context, index) {
                          if (index == 5) {
                            return const SizedBox(
                              height: 64,
                            );
                          }
                          return Stack(
                            children: [
                              SizedBox(
                                height: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Seat(
                                        index: index,
                                        updateTotalSeats: updateParameter),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Seat(
                                        index: index,
                                        updateTotalSeats: updateParameter),
                                    const SizedBox(
                                      width: 32,
                                    ),
                                    Seat(
                                        index: index,
                                        updateTotalSeats: updateParameter),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Seat(
                                        index: index,
                                        updateTotalSeats: updateParameter),
                                  ],
                                ),
                              ),
                            ],
                          );
                        })
                  ],
                ),
              ),
            );
          }),
    );
  }
}
