import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mars/first_page.dart/part1/app_title.dart';
import 'package:mars/first_page.dart/part1/button.dart';
import 'package:mars/first_page.dart/location_mark.dart';
import 'package:mars/first_page.dart/part1/planet.dart';
import 'package:mars/first_page.dart/planet_glow.dart';
import 'package:mars/first_page.dart/planet_glow_gradient.dart';
import 'package:mars/first_page.dart/part1/planet_name.dart';
import 'package:mars/first_page.dart/part3/zone_detail.dart';
import 'package:mars/first_page.dart/part2/zone_list.dart';

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

  late final AnimationController planetController, zoneController;
  late final Animation planetAnimation, zoneAnimation;
  double variableValue = 0.0;
  double variableValue2 = 0.0;
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
    planetController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    zoneController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    planetAnimation =
        CurvedAnimation(parent: planetController, curve: Curves.easeInOutCirc);
    zoneAnimation =
        CurvedAnimation(parent: zoneController, curve: Curves.easeInOutCirc);
    planetController.addListener(() {
      variableValue = planetAnimation.value;
      setState(() {});
    });
    zoneController.addListener(() {
      variableValue2 = zoneAnimation.value;
      setState(() {});
    });
    planetController.addStatusListener((status) {
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
    zoneController.addStatusListener((status) {
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
    planetController.dispose();
    zoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        if (variableValue2 == 1) {
          setState(() {
            showDetails = !showDetails;
          });
          zoneController.reverse();
          Future<bool> closeApp = Future.value(false);
          return closeApp;
        } else if (variableValue == 1) {
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
                opacity: 1 - variableValue2,
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
            Opacity(opacity: 1 - variableValue, child: const AppTitle()),
            Opacity(
                opacity: 1 - 0.5 * variableValue,
                child: Transform.scale(
                  scale: 1 + 0.2 * variableValue,
                  child: Transform.translate(
                      offset: Offset(6 * variableValue,
                          -variableValue * size.height * 0.3),
                      child: PlanetGlowGradient(
                        begin: showZone ? 0.6 : 0.0,
                      )),
                )),
            Opacity(
              opacity: 1 - 0.2 * variableValue,
              child: Transform.scale(
                scale: 1 - 0.32 * variableValue,
                child: Transform.translate(
                    offset: Offset(8, -variableValue * size.height * 0.34),
                    child: PlanetGlow(
                      begin: showZone ? 0.5 : 0.0,
                    )),
              ),
            ),
            Transform.scale(
                scale: 1 - 0.3 * variableValue,
                child: Transform.translate(
                    offset: Offset(0, variableValue * 100),
                    child: const PlanetName())),
            Transform.translate(
              offset: Offset(-size.width * offsetWidthFactor * variableValue2,
                  -size.height * offsetHeightFactor * variableValue2),
              child: Transform.scale(
                scale: 1 + 2 * variableValue2,
                child: Transform.scale(
                  scale: 1 - 0.32 * variableValue,
                  child: Transform.translate(
                      offset: Offset(8, -variableValue * (size.height) * 0.34),
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
                              zoneController.reset();
                              zoneController.forward();
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
                      planetController.reset();
                      planetController.forward();
                    },
                    child: const ButtonColumn(),
                  )
                : const SizedBox(),
            showZone
                ? Opacity(opacity: 1 - variableValue2, child: const ZoneList())
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
                  zoneController.reverse();
                },
              )
          ],
        ),
      ),
    );
  }
}
