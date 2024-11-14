// ignore_for_file: library_private_types_in_public_api, must_be_immutable
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glass/glass.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guid/ad_manager/banner_ad.dart';
import 'package:guid/ad_manager/interstitial_ad.dart';
import 'package:guid/model_view/data_provider.dart';
import 'package:guid/model_view/menu_provider.dart';
import 'package:guid/utils/colors_utils.dart';
import 'package:guid/utils/icons_constants.dart';
import 'package:guid/utils/utils.dart';
import 'package:guid/view/chapters/chapters.dart';
import 'package:guid/view/home/home.dart';
import 'package:guid/view/profile/profile.dart';
import 'package:guid/view/save/saved_articles.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int selectedIndex = 0;
  List pages = [const Home(), const ChaptersScreen(), const SavedArticles(), const Profile()];
  final InAppReview inAppReview = InAppReview.instance;
  Future<void> requestReview() => inAppReview.requestReview();

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(
      builder: (context, value, child) => WillPopScope(
        onWillPop: () async {
          if (value.index != 0) {
            AppInterstitialAd.show();

            value.setIndex(0);
            return false;
          }
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.black.withOpacity(0.800000011920929),
                  title: Text(
                    'Exit',
                    style: GoogleFonts.skranji(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  content: Text(
                    'Are you sure you want to exit?',
                    style: GoogleFonts.skranji(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('No',
                          style: GoogleFonts.skranji(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    TextButton(
                      onPressed: () {
                        if (Platform.isAndroid) {
                          SystemNavigator.pop();
                        } else if (Platform.isIOS) {
                          exit(0);
                        }
                      },
                      child: Text(
                        'Yes',
                        style: GoogleFonts.skranji(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        requestReview();
                      },
                      child: Text(
                        'Rate Us',
                        style: GoogleFonts.skranji(
                          color: Colors.yellow,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                );
              });
          return Future.value(false);
        },
        child: Scaffold(
          extendBody: true,
          body: pages[value.index],
          backgroundColor: Colors.white,
          bottomNavigationBar: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBannerAd(),
              CustomBottomNavigationBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<MenuProvider, DataProvider>(
      builder: (context, value, value2, child) => Container(
          height: 73,
          decoration: BoxDecoration(
            // border: Border.all(
            //   color: Colors.black.withOpacity(0.05),
            // ),
            boxShadow: value.index == 3
                ? const [
                    BoxShadow(
                      color: Color(0x0C000000),
                      blurRadius: 30,
                      offset: Offset(0, -10),
                      spreadRadius: 0,
                    )
                  ]
                : null,
            color: value.index != 3 ? Colors.white.withOpacity(0.2) : Colors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: Container(
            height: 73,
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                bool isSelected = value.index == index;
                return GestureDetector(
                  onTap: () {
                    AppInterstitialAd.show();

                    value.setIndex(index);
                    _animationController.forward().then((value) {
                      _animationController.reset();
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: isSelected ? 89.68 : 40,
                    height: 42.50,
                    decoration: isSelected
                        ? BoxDecoration(
                            color: hexToColor(value2.data.mainColor.toString()),
                            borderRadius: BorderRadius.circular(30),
                          )
                        : const BoxDecoration(),
                    child: Center(
                      child: appIcon(
                          isSelected ? getfillIconForIndex(index) : getIconForIndex(index),
                          false,
                          context,
                          20,
                          20,
                          color: isSelected ? Colors.white : Colors.black.withOpacity(0.4)),
                    ),
                  ),
                );
              }),
            ),
          ).asGlass(
            enabled: value.index != 3,
            blurX: 5,
            blurY: 5,
          )),
    );
  }

  String getIconForIndex(int index) {
    switch (index) {
      case 0:
        return IconsConstants.home;
      case 1:
        return IconsConstants.chapter;
      case 2:
        return IconsConstants.save;
      case 3:
        return IconsConstants.profile;
      default:
        return IconsConstants.home;
    }
  }

  String getfillIconForIndex(int index) {
    switch (index) {
      case 0:
        return IconsConstants.homefill;
      case 1:
        return IconsConstants.chapterfill;
      case 2:
        return IconsConstants.savefill;
      case 3:
        return IconsConstants.profilefill;
      default:
        return IconsConstants.homefill;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
