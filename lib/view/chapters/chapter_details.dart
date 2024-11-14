import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guid/ad_manager/interstitial_ad.dart';
import 'package:guid/model/data.dart';
import 'package:guid/model_view/data_provider.dart';
import 'package:guid/utils/icons_constants.dart';
import 'package:guid/utils/utils.dart';
import 'package:guid/view/home/widget/article_details.dart';
import 'package:guid/view/home/widget/article_item.dart';
import 'package:provider/provider.dart';

class ChapterDetails extends StatefulWidget {
  final Chapters chapter;
  final int index;
  const ChapterDetails({super.key, required this.chapter, required this.index});

  @override
  State<ChapterDetails> createState() => _ChapterDetailsState();
}

class _ChapterDetailsState extends State<ChapterDetails> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) => Scaffold(
        extendBody: true,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 180,
                child: Stack(
                  children: [
                    Image.asset(
                      widget.chapter.cover.toString(),
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
                            'Chapter ${widget.index + 1}',
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.museoModerno(
                                color:
                                    Colors.white.withOpacity(0.699999988079071),
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            widget.chapter.title.toString(),
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.museoModerno(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                            AppInterstitialAd.show();

                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40, right: 20),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Opacity(
                            opacity: 0.80,
                            child: Container(
                                height: 30,
                                width: 30,
                                decoration: ShapeDecoration(
                                  color: Colors.white
                                      .withOpacity(0.699999988079071),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                child: appIcon(IconsConstants.close, false,
                                    context, 16, 16)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 5),
                  itemCount: widget.chapter.articles!.length,
                  itemBuilder: (context, index) {
                    List<Articles> allArticles = widget.chapter.articles!;
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticleDetails(
                              articles: allArticles[index],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: articlItem(context, allArticles, index, value),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
