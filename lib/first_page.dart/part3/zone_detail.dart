import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mars/custom_animation.dart';
import 'package:mars/first_page.dart/part3/planet_property.dart';
import 'package:mars/second_page/choose_seat.dart';

String aboutMars =
    "Finally a place as dry as your kindness. Mars is the fourth planet from the sun and the second smallest planet in the solar syatem after Mercury. Mars carries a name of the Roman god od war, and is often referred to as Red Planet.";

String title = "";

String getTitle(int zone) {
  String zoneTitle = "";
  if (zone == 1) {
    zoneTitle = "Zone $zone \nMillionary land";
  } else if (zone == 2) {
    zoneTitle = "Zone $zone \nBillionary land";
  } else if (zone == 3) {
    zoneTitle = "Zone $zone \nTrillionary land";
  } else if (zone == 4) {
    zoneTitle = "Zone $zone \nZillionary land";
  } else if (zone == 5) {
    zoneTitle = "Zone $zone \nCentillionary land";
  }
  return zoneTitle;
}

class ZoneDetail extends StatelessWidget {
  final VoidCallback backButtonPressed;
  final int currentZone;
  const ZoneDetail({
    Key? key,
    required this.backButtonPressed,
    required this.currentZone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.only(left: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Transform.translate(
                offset: const Offset(-16, 0),
                child: IconButton(
                    onPressed: backButtonPressed,
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    )),
              ),
              TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOut,
                  builder: (context, double value, _) {
                    return Opacity(
                      opacity: value * value,
                      child: Transform.translate(
                        offset: Offset(0, -20 * (1 - value)),
                        child: Text(
                          getTitle(currentZone),
                          style: GoogleFonts.oxygen(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    );
                  }),
              const SizedBox(height: 320),
              CustomFadeAnimatedWidget(
                delay: 200,
                child: Text(
                  "Pictures",
                  style: GoogleFonts.oxygen(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 20),
              CustomFadeAnimatedWidget(
                delay: 400,
                child: SizedBox(
                  height: 185,
                  width: double.infinity,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: SizedBox(
                              width: 140,
                              child: Image.asset(
                                "assets/mars${index + 1}.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              const SizedBox(height: 40),
              CustomFadeAnimatedWidget(
                delay: 600,
                child: Text(
                  "Description",
                  style: GoogleFonts.oxygen(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 10),
              CustomFadeAnimatedWidget(
                delay: 800,
                child: Padding(
                  padding: const EdgeInsets.only(right: 36),
                  child: Text(
                    aboutMars,
                    style: GoogleFonts.oxygen(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w100,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              CustomFadeAnimatedWidget(
                delay: 1000,
                child: Padding(
                  padding: const EdgeInsets.only(right: 36),
                  child: SizedBox(
                    height: 280,
                    width: double.infinity,
                    child: GridView(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.92),
                      children: const [
                        PlanetProperty(label: "Degrees", value: -63),
                        PlanetProperty(label: "Ratio Km", value: 3.389),
                        PlanetProperty(label: "Dist Mil. Km", value: 225),
                        PlanetProperty(label: "Any", value: 945),
                        PlanetProperty(label: "Proterty", value: 1.274),
                        PlanetProperty(label: "Name", value: 54),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomFadeAnimatedWidget(
                delay: 1200,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder:
                                (context, animaton, secondaryAnimation) {
                              return const ChooseSeat();
                            },
                            transitionDuration:
                                const Duration(milliseconds: 800),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              animation = CurvedAnimation(
                                  parent: animation, curve: Curves.easeInOut);
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            }));
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 36),
                      child: Container(
                        width: 225,
                        margin: const EdgeInsets.only(bottom: 50),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2, color: Colors.white),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            "Choose seats",
                            style: GoogleFonts.oxygen(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
