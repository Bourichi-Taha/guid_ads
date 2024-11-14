import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guid/ad_manager/interstitial_ad.dart';
import 'package:guid/model_view/data_provider.dart';
import 'package:guid/utils/colors_utils.dart';
import 'package:guid/utils/icons_constants.dart';
import 'package:guid/utils/utils.dart';
import 'package:guid/view/home/widget/article_details.dart';
import 'package:provider/provider.dart';

class SavedArticles extends StatefulWidget {
  const SavedArticles({super.key});

  @override
  State<SavedArticles> createState() => _SavedArticlesState();
}

class _SavedArticlesState extends State<SavedArticles> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) => SizedBox(
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
                  height: 22,
                  child: Text(
                    'Saved articles',
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
                //gridview
                if (value.savedArticles.isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          appIcon(
                            IconsConstants.savefill,
                            false,
                            context,
                            100,
                            100,
                            color: hexToColor(value.data.mainColor.toString()),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'No saved articles',
                            style: GoogleFonts.museoModerno(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.60,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.only(top: 5),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 0.9, crossAxisSpacing: 24),
                      itemCount: value.savedArticles.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(100),
                                onTap: () {
                                  AppInterstitialAd.show();

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ArticleDetails(
                                        articles: value.savedArticles[index],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: AssetImage(value.savedArticles[index].icon.toString()),
                                      fit: BoxFit.cover,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 10,
                                        offset: Offset(0, 1),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(100),
                                            onTap: () async {
                                              await value.removeArticle(value.savedArticles[index]);
                                            },
                                            child: Container(
                                              width: 28,
                                              height: 28,
                                              decoration: ShapeDecoration(
                                                color: const Color(0xFFE4E9F0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(500),
                                                ),
                                              ),
                                              child: Center(
                                                child: appIcon(
                                                    IconsConstants.savefill, false, context, 16, 16,
                                                    color: hexToColor(
                                                        value.data.mainColor.toString())),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 15,
                              child: Text(
                                value.savedArticles[index].title.toString(),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: GoogleFonts.museoModerno(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
              ],
            ),
          )),
    );
  }
}
