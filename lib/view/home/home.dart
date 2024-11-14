import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guid/ad_manager/interstitial_ad.dart';
import 'package:guid/ad_manager/native_ad.dart';
import 'package:guid/model/data.dart';
import 'package:guid/model_view/data_provider.dart';
import 'package:guid/view/home/widget/article_details.dart';
import 'package:provider/provider.dart';

import 'widget/article_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

List<Articles> getAllArticles(Data data) {
  List<Articles> allArticles = [];

  if (data.chapters != null) {
    for (var chapter in data.chapters!) {
      if (chapter.articles != null) {
        allArticles.addAll(chapter.articles!);
      }
    }
  }

  return allArticles;
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    AppInterstitialAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (BuildContext context, value, Widget? child) => SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
              const SizedBox(height: 23),
              SizedBox(
                height: 22,
                child: Text(
                  'Last articles',
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
                child: ListView.separated(
                  padding: const EdgeInsets.only(top: 5),
                  itemCount: getAllArticles(value.data).length,
                  itemBuilder: (BuildContext context, int index) {
                    List<Articles> allArticles = getAllArticles(value.data);
                    return InkWell(
                        onTap: () {
                          AppInterstitialAd.show();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArticleDetails(
                                articles: allArticles[index],
                              ),
                            ),
                          );
                        },
                        child: articlItem(context, allArticles, index, value));
                  },
                  separatorBuilder: (context, index) {
                    return index == 0
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: AppNativeAd(
                              key: UniqueKey(),
                            ))
                        : Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TruncatedText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final double maxHeight; // Maximum height of the text area (e.g., 4 lines)

  const TruncatedText({
    super.key,
    required this.text,
    required this.style,
    required this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Create a TextPainter to calculate text layout
        final TextPainter textPainter = TextPainter(
          text: TextSpan(text: text, style: style),
          maxLines: 4, // Set max lines to 4
          textDirection: TextDirection.ltr,
        );

        textPainter.layout(maxWidth: constraints.maxWidth * 0.9);

        // Check if text fits within the allowed height
        if (textPainter.didExceedMaxLines || textPainter.height > maxHeight) {
          // Find the position to truncate
          final position =
              textPainter.getPositionForOffset(Offset(constraints.maxWidth * 0.9, maxHeight));

          // Get the text until that position
          final endOffset = textPainter.getOffsetBefore(position.offset) ?? text.length;
          String truncatedText = text.substring(0, endOffset).trim();

          // Add the ellipsis and arrow
          //function to add ellipsis and arrow

          truncatedText += '...';

          return Text(
            truncatedText,
            style: style,
            maxLines: 4,
            overflow: TextOverflow.clip,
          );
        } else {
          // If it fits, display the full text
          return Text(
            text,
            style: style,
            maxLines: 4,
            overflow: TextOverflow.clip,
          );
        }
      },
    );
  }
}
