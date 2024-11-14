import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guid/ad_manager/interstitial_ad.dart';
import 'package:guid/model_view/data_provider.dart';
import 'package:guid/view/chapters/chapter_details.dart';
import 'package:provider/provider.dart';

class ChaptersScreen extends StatefulWidget {
  const ChaptersScreen({super.key});

  @override
  State<ChaptersScreen> createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends State<ChaptersScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (BuildContext context, value, child) => SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                top: true,
                left: false,
                right: false,
                bottom: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi 👋, this is your guide for',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 15,
                            fontFamily: 'Abel',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          value.data.appName.toString(),
                          style: GoogleFonts.museoModerno(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.60,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        image: DecorationImage(
                          image: AssetImage(value.data.appIcon.toString()),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 23,
              ),
              SizedBox(
                child: Text(
                  'Chapters',
                  style: GoogleFonts.museoModerno(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.60,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 5),
                  itemCount: value.data.chapters!.length,
                  itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        AppInterstitialAd.show();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChapterDetails(chapter: value.data.chapters![index], index: index),
                          ),
                        );
                      },
                      child: chapterItem(value, index)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container chapterItem(DataProvider value, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 170,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Image.asset(
            value.data.chapters![index].cover.toString(),
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.4),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Chapter ${value.data.chapters![index].order}',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.museoModerno(
                      color: Colors.white.withOpacity(0.699999988079071),
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  value.data.chapters![index].title.toString(),
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.museoModerno(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
