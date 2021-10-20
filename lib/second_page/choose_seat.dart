import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mars/first_page.dart/home_page.dart';
import 'package:mars/second_page/seat.dart';
import 'package:mars/second_page/seat_clipper.dart';
import 'package:mars/second_page/seat_column.dart';

class ChooseSeat extends StatefulWidget {
  const ChooseSeat({Key? key}) : super(key: key);

  @override
  _ChooseSeatState createState() => _ChooseSeatState();
}

class _ChooseSeatState extends State<ChooseSeat> with TickerProviderStateMixin {
  late final AnimationController planeArrivalAnimationController,
      planeDepartAnimationController;
  late final Animation planeArrivalAnimationPart1,
      planeArrivalAnimationPart2,
      planeDepartAnimationPart1,
      planeDepartAnimationPart2;

  final GlobalKey<AnimatedListState> listState = GlobalKey<AnimatedListState>();

  double variableValue1 = 0.0;
  double variableValue2 = 0.0;

  int totalSeatsToBook = 0;
  String buttonText = "Book Seat";

  bool showSeats = false;
  bool showBookButton = false;

  void updateParameter(bool isChosen) {
    setState(() {
      if (isChosen) {
        totalSeatsToBook++;
      } else {
        totalSeatsToBook--;
      }
      if (totalSeatsToBook > 1) {
        buttonText = "Book Seats";
      } else {
        buttonText = "Book Seat";
      }
      if (totalSeatsToBook > 0) {
        showBookButton = true;
      } else {
        showBookButton = false;
      }
    });
  }

  void initialization() {
    planeArrivalAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4000));
    planeDepartAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4000));

    planeArrivalAnimationPart1 = CurvedAnimation(
        parent: planeArrivalAnimationController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeInOutCirc));
    planeArrivalAnimationPart2 = CurvedAnimation(
        parent: planeArrivalAnimationController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeInOutCubic));
    planeDepartAnimationPart1 = CurvedAnimation(
        parent: planeDepartAnimationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOutCirc));
    planeDepartAnimationPart2 = CurvedAnimation(
        parent: planeDepartAnimationController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeInOutCubic));

    planeArrivalAnimationController.addListener(() {
      variableValue1 = planeArrivalAnimationPart1.value;
      variableValue2 = planeArrivalAnimationPart2.value;
      setState(() {});
    });
    planeDepartAnimationController.addListener(() {
      setState(() {});
    });

    planeArrivalAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          showSeats = !showSeats;
        });
      } else if (status == AnimationStatus.dismissed) {
        Navigator.pop(context);
      }
    });

    planeDepartAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          showSeats = false;
        });
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return const HomePage();
        }), (route) => false);
      }
    });

    showSeats = false;
    planeArrivalAnimationController.reset();
    planeArrivalAnimationController.forward();
  }

  @override
  void initState() {
    initialization();
    super.initState();
  }

  @override
  void dispose() {
    planeArrivalAnimationController.dispose();
    planeDepartAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        if (variableValue2 == 1) {
          setState(() {
            showSeats = false;
          });
          planeArrivalAnimationController.reverse();
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: showBookButton
              ? TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.easeInOut,
                  builder: (context, double value, _) {
                    return Opacity(
                      opacity: value,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.white),
                            borderRadius: BorderRadius.circular(16)),
                        child: FloatingActionButton.extended(
                            backgroundColor: Colors.transparent,
                            onPressed: () {
                              setState(() {
                                showBookButton = !showBookButton;
                              });
                              planeDepartAnimationController.reset();
                              planeDepartAnimationController.forward();
                            },
                            label: Text(
                              buttonText,
                              style: GoogleFonts.oxygen(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                    );
                  })
              : const SizedBox(),
          backgroundColor: const Color(0xff040405),
          body: Transform.translate(
            offset:
                Offset(0, -2 * size.height * planeDepartAnimationPart2.value),
            child: Transform.scale(
              scale: 1 - 0.75 * planeDepartAnimationPart1.value,
              child: Stack(
                children: [
                  Transform.scale(
                    scale: 1 + 3.8 * variableValue2,
                    child: Opacity(
                      opacity: variableValue1,
                      child: Transform.translate(
                        offset:
                            Offset(0, 2 * size.height * (1 - variableValue1)),
                        child: Transform.scale(
                          scale: 1 * variableValue1,
                          child: Center(
                            child: Image.asset("assets/aeroplane.png"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (showSeats)
                    SeatColumn(
                      animationValue: planeDepartAnimationPart1.value,
                      size: size,
                      updateParameter: updateParameter,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
