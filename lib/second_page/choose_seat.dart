import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mars/home_page.dart';

class ChooseSeat extends StatefulWidget {
  const ChooseSeat({Key? key}) : super(key: key);

  @override
  _ChooseSeatState createState() => _ChooseSeatState();
}

class _ChooseSeatState extends State<ChooseSeat> with TickerProviderStateMixin {
  late final AnimationController ac, ac2;
  late final Animation a, a2, b, b2;

  final GlobalKey<AnimatedListState> listState = GlobalKey<AnimatedListState>();

  double v = 0.0;
  double v2 = 0.0;

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

  @override
  void initState() {
    ac = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4000));
    ac2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4000));

    a = CurvedAnimation(
        parent: ac,
        curve: const Interval(0.0, 0.4, curve: Curves.easeInOutCirc));
    a2 = CurvedAnimation(
        parent: ac,
        curve: const Interval(0.4, 1.0, curve: Curves.easeInOutCubic));
    b = CurvedAnimation(
        parent: ac2,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOutCirc));
    b2 = CurvedAnimation(
        parent: ac2,
        curve: const Interval(0.6, 1.0, curve: Curves.easeInOutCubic));

    ac.addListener(() {
      v = a.value;
      v2 = a2.value;
      setState(() {});
    });
    ac2.addListener(() {
      setState(() {});
    });

    ac.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          showSeats = !showSeats;
        });
      } else if (status == AnimationStatus.dismissed) {
        Navigator.pop(context);
      }
    });

    ac2.addStatusListener((status) {
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
    ac.reset();
    ac.forward();

    super.initState();
  }

  @override
  void dispose() {
    ac.dispose();
    ac2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        if (v2 == 1) {
          setState(() {
            showSeats = false;
          });
          ac.reverse();
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
                              ac2.reset();
                              ac2.forward();
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
            offset: Offset(0, -2 * size.height * b2.value),
            child: Transform.scale(
              scale: 1 - 0.75 * b.value,
              child: Stack(
                children: [
                  Transform.scale(
                    scale: 1 + 3.8 * v2,
                    child: Opacity(
                      opacity: v,
                      child: Transform.translate(
                        offset: Offset(0, 2 * size.height * (1 - v)),
                        child: Transform.scale(
                          scale: 1 * v,
                          child: Center(
                            child: Image.asset("assets/aeroplane.png"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (showSeats)
                    Opacity(
                      opacity: 1.0 - b.value,
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Seat(
                                                        index: index,
                                                        updateTotalSeats:
                                                            updateParameter),
                                                    const SizedBox(
                                                      width: 16,
                                                    ),
                                                    Seat(
                                                        index: index,
                                                        updateTotalSeats:
                                                            updateParameter),
                                                    const SizedBox(
                                                      width: 32,
                                                    ),
                                                    Seat(
                                                        index: index,
                                                        updateTotalSeats:
                                                            updateParameter),
                                                    const SizedBox(
                                                      width: 16,
                                                    ),
                                                    Seat(
                                                        index: index,
                                                        updateTotalSeats:
                                                            updateParameter),
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
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Seat extends StatefulWidget {
  final int index;
  final Function(bool) updateTotalSeats;
  const Seat({Key? key, required this.index, required this.updateTotalSeats})
      : super(key: key);

  @override
  State<Seat> createState() => _SeatState();
}

class _SeatState extends State<Seat> {
  Color color = Colors.white;
  bool isOccupied = false;
  bool isChosen = false;

  @override
  void initState() {
    isOccupied = Random().nextBool();
    if (isOccupied && widget.index < 10) {
      color = const Color(0xff2d2c2d);
    } else {
      isOccupied = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isOccupied) {
          setState(() {
            isChosen = !isChosen;
            widget.updateTotalSeats(isChosen);
          });
        }
      },
      child: Icon(
        Icons.chair,
        color: isChosen ? const Color(0xfffa8e16) : color,
        size: 32,
      ),
    );
  }
}

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
