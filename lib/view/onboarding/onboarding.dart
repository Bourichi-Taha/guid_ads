import 'package:guid/model_view/data_provider.dart';
import 'package:guid/utils/colors_utils.dart';
import 'package:guid/view/onboarding/widgets/indicator.dart';
import 'package:guid/view/onboarding/widgets/onboarding_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  //page controller
  final PageController controller = PageController(
    initialPage: 0,
  );
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) => Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.7,
                  child: PageView(
                    controller: controller,
                    children: [
                      for (var i = 0; i < value.data.intro!.length; i++)
                        onboardingItem(context, value, i),
                    ],
                    onPageChanged: (int index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      indicatorItems(value, currentPage),
                      const SizedBox(height: 27),
                      Text(
                        value.data.intro![currentPage].title.toString(),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.abel(
                          color: const Color(0xFF27214D),
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.24,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Opacity(
                        opacity: 0.60,
                        child: Text(
                          value.data.intro![currentPage].description.toString(),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: const TextStyle(
                            color: Color(0xFF5C577E),
                            fontSize: 16,
                            fontFamily: 'Abel',
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 80,
                  child: Column(
                    children: [
                      if (currentPage == 0)
                        InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width - 48,
                            height: 51,
                            decoration: ShapeDecoration(
                              color:
                                  hexToColor(value.data.mainColor.toString()),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Next',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.abel(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (currentPage != 0) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: SizedBox(
                            height: 51,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(100),
                                  onTap: () {
                                    controller.previousPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeIn,
                                    );
                                  },
                                  child: Container(
                                    width: 104.71,
                                    height: 51,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFB7B7B7),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                    //next text child
                                    child: Center(
                                      child: Text(
                                        'Back',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.abel(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.22,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(100),
                                  onTap: () {
                                    if (currentPage ==
                                        value.data.intro!.length - 1) {
                                      Navigator.pushReplacementNamed(
                                          context, '/menu');
                                    }
                                    if (currentPage <
                                        value.data.intro!.length - 1) {
                                      controller.nextPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeIn,
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: 104.71,
                                    height: 51,
                                    decoration: ShapeDecoration(
                                      color: hexToColor(
                                          value.data.mainColor.toString()),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                    //next text child
                                    child: Center(
                                      child: Text(
                                        'Next',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.abel(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.22,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ],
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
