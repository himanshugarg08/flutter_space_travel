import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mars/app_title.dart';
import 'package:mars/button.dart';
import 'package:mars/location_mark.dart';
import 'package:mars/planet.dart';
import 'package:mars/planet_glow.dart';
import 'package:mars/planet_glow_gradient.dart';
import 'package:mars/planet_name.dart';
import 'package:mars/zone_detail.dart';
import 'package:mars/zone_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool showButton = false;
  bool showZone = false;
  bool isZoneTapped = false;
  bool showDetails = false;
  bool canClick = false;

  late final AnimationController ac, ac2;
  late final Animation a, a2;
  double v = 0.0;
  double v2 = 0.0;
  double offsetWidthFactor = 0;
  double offsetHeightFactor = 0;
  int currentZone = 0;

  Future ft = Future(() {});

  List<bool> locationShow = [false, false, false, false, false];
  List<Map<String, double>> locationValues = [
    {"x": 0.22, "y": 0},
    {"x": 0.7, "y": -0.05},
    {"x": -0.1, "y": -0.3},
    {"x": 0.1, "y": 0.35},
    {"x": -0.7, "y": 0.1},
  ];

  @override
  void initState() {
    ac = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    ac2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    a = CurvedAnimation(parent: ac, curve: Curves.easeInOutCirc);
    a2 = CurvedAnimation(parent: ac2, curve: Curves.easeInOutCirc);
    ac.addListener(() {
      v = a.value;
      setState(() {});
    });
    ac2.addListener(() {
      v2 = a2.value;
      setState(() {});
    });
    ac.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        showZone = !showZone;

        for (int i = 0; i < locationShow.length; i++) {
          ft = ft.then((_) {
            return Future.delayed(const Duration(milliseconds: 800), () {
              setState(() {
                locationShow[i] = true;
                if (i == locationShow.length - 1) {
                  canClick = !canClick;
                }
              });
            });
          });
        }
      }
    });
    ac2.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        showDetails = !showDetails;
      } else if (status == AnimationStatus.dismissed) {
        for (int i = 0; i < locationShow.length; i++) {
          locationShow[i] = true;
        }
        setState(() {});
      }
    });
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
            showDetails = !showDetails;
          });
          ac2.reverse();
          Future<bool> closeApp = Future.value(false);
          return closeApp;
        } else if (v == 1) {
          // Navigator.pushAndRemoveUntil(context,
          //     MaterialPageRoute(builder: (context) {
          //   return const HomePage();
          // }), (route) => false);
        }
        Future<bool> closeApp = Future.value(true);
        return closeApp;
      },
      child: Scaffold(
        backgroundColor: const Color(0xff040405),
        body: Stack(
          children: [
            if (showZone)
              Opacity(
                opacity: 1 - v2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 100.0),
                  child: TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeOut,
                      builder: (context, double value, _) {
                        return Opacity(
                          opacity: value * value,
                          child: Transform.translate(
                            offset: Offset(0, -20 * (1 - value)),
                            child: SizedBox(
                              height: 100,
                              width: 300,
                              child: Text(
                                "Where do you want to go?",
                                style: GoogleFonts.oxygen(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    height: 0.8 + 0.4 * value),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            Opacity(opacity: 1 - v, child: const AppTitle()),
            Opacity(
                opacity: 1 - 0.5 * v,
                child: Transform.scale(
                  scale: 1 + 0.2 * v,
                  child: Transform.translate(
                      offset: Offset(6 * v, -v * size.height * 0.3),
                      child: PlanetGlowGradient(
                        begin: showZone ? 0.6 : 0.0,
                      )),
                )),
            Opacity(
              opacity: 1 - 0.2 * v,
              child: Transform.scale(
                scale: 1 - 0.32 * v,
                child: Transform.translate(
                    offset: Offset(8, -v * size.height * 0.34),
                    child: PlanetGlow(
                      begin: showZone ? 0.5 : 0.0,
                    )),
              ),
            ),
            Transform.scale(
                scale: 1 - 0.3 * v,
                child: Transform.translate(
                    offset: Offset(0, v * 100), child: const PlanetName())),
            Transform.translate(
              offset: Offset(-size.width * offsetWidthFactor * v2,
                  -size.height * offsetHeightFactor * v2),
              child: Transform.scale(
                scale: 1 + 2 * v2,
                child: Transform.scale(
                  scale: 1 - 0.32 * v,
                  child: Transform.translate(
                      offset: Offset(8, -v * (size.height) * 0.34),
                      child: Planet(
                        begin: showZone ? 1.0 : 2.0,
                        afterEnd: () {
                          setState(() {
                            showButton = !showButton;
                          });
                        },
                      )),
                ),
              ),
            ),
            if (showZone)
              ...List.generate(
                  locationShow.length,
                  (index) => locationShow[index]
                      ? GestureDetector(
                          onTap: () {
                            if (canClick) {
                              for (int i = 0; i < locationShow.length; i++) {
                                locationShow[i] = false;
                              }
                              currentZone = index;
                              offsetWidthFactor = locationValues[index]["x"]!;
                              offsetHeightFactor = locationValues[index]["y"]!;
                              ac2.reset();
                              ac2.forward();
                            }
                          },
                          child: LocationMark(
                              x: locationValues[index]["x"]!,
                              y: locationValues[index]["y"]!,
                              milliseconds: 600),
                        )
                      : const SizedBox()),
            showButton && !showZone
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        showButton = !showButton;
                      });
                      ac.reset();
                      ac.forward();
                    },
                    child: const ButtonColumn(),
                  )
                : const SizedBox(),
            showZone
                ? Opacity(opacity: 1 - v2, child: const ZoneList())
                : const SizedBox(),
            if (showDetails)
              LocationMark(
                  x: locationValues[currentZone]["x"]!,
                  y: currentZone == 3
                      ? locationValues[currentZone]["y"]! - 0.15
                      : locationValues[currentZone]["y"]!,
                  milliseconds: 1200,
                  withAnimation: true),
            if (showDetails)
              ZoneDetail(
                currentZone: currentZone + 1,
                backButtonPressed: () {
                  setState(() {
                    showDetails = !showDetails;
                  });
                  ac2.reverse();
                },
              )
          ],
        ),
      ),
    );
  }
}
