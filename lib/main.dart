import 'dart:convert';

import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:guid/model/data.dart';
import 'package:guid/model_view/data_provider.dart';
import 'package:guid/model_view/menu_provider.dart';
import 'package:guid/view/Splash.dart';
import 'package:guid/view/brand.dart';
import 'package:guid/view/menu/menu.dart';
import 'package:guid/view/onboarding/onboarding.dart';
import 'package:guid/view/profile/profile.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

enum AdNetwork { admob, facebook, unity, applovin }

AdNetwork selectedAdNetwork = AdNetwork.applovin;

///creat by Mfagri
Data data = Data();

//this for package info
PackageInfo? packageInfo = PackageInfo(
  appName: 'Unknown',
  packageName: 'Unknown',
  version: 'Unknown',
  buildNumber: 'Unknown',
);

bool firstTime = false;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    MobileAds.instance.initialize(),
    FacebookAudienceNetwork.init(
      testingId: "bfe47acb-dd50-43d6-8d3c-a65f0a6cee42",
    ),
    UnityAds.init(
      gameId: "5712423",
      testMode: true,
      onComplete: () {},
      onFailed: (error, message) {},
    ),
  ]);
  packageInfo = await PackageInfo.fromPlatform();
  //read json file from assets
  final json = await rootBundle.loadString('assets/db.json');
  final config = jsonDecode(json);
  data = Data.fromJson(config);

  List<Chapters> sortedChapters = data.chapters ?? [];
  sortedChapters.sort((a, b) => a.order!.compareTo(b.order!));

  for (var chapter in sortedChapters) {
    List<Articles> sortedArticles = chapter.articles ?? [];
    sortedArticles.sort((a, b) => a.order!.compareTo(b.order!));

    for (var article in sortedArticles) {
      List<Items> sortedItems = article.items ?? [];
      sortedItems.sort((a, b) => a.index!.compareTo(b.index!));
      article.items = sortedItems;
    }
    chapter.articles = sortedArticles;
  }

  //camera permission
  SharedPreferences prefs = await SharedPreferences.getInstance();
  firstTime = (prefs.getBool('isfirsttime') ?? false);
  if (!firstTime) {
    prefs.setBool('isfirsttime', true);
  }
  //for testing multiple devices
  // runApp(DevicePreview(
  //   enabled: true,
  //   builder: (context) => const MyApp(),
  // ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(create: (context) => MenuProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          scaffoldBackgroundColor: const Color(0xffFFFCFC),
          useMaterial3: true,
        ),
        initialRoute: '/brand',
        routes: {
          '/': (context) => const SplashScreen(),
          '/brand': (context) => const BrandScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
          '/menu': (context) => const MenuPage(),
          '/profile': (context) => const Profile(),
        },
      ),
    );
  }
}
