// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guid/ad_manager/interstitial_ad.dart';
import 'package:guid/main.dart';
import 'package:guid/model/data.dart';
import 'package:guid/model_view/data_provider.dart';
import 'package:guid/utils/colors_utils.dart';
import 'package:guid/utils/icons_constants.dart';
import 'package:guid/utils/utils.dart';
import 'package:provider/provider.dart';

class ArticleDetails extends StatefulWidget {
  final Articles articles;
  const ArticleDetails({super.key, required this.articles});

  @override
  State<ArticleDetails> createState() => _ArticlDetailsState();
}

class _ArticlDetailsState extends State<ArticleDetails> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) => Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SafeArea(
              top: true,
              bottom: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Rayman Raving Rabbids',
                    style: GoogleFonts.museoModerno(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.45,
                    ),
                  ),
                  Opacity(
                    opacity: 0.80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () async {
                            if (mounted) {
                            AppInterstitialAd.show();

                              try {
                                //check if article is already saved
                                if (value.isArticleSaved(widget.articles)) {
                                  //ask if he want remove
                                  final bool? remove = await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Remove article'),
                                        content: const Text(
                                            'Are you sure you want to remove this article?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, false);
                                            },
                                            child: Text('No',
                                                style: TextStyle(
                                                    color: hexToColor(
                                                        data.mainColor))),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, true);
                                            },
                                            child: Text('Yes',
                                                style: TextStyle(
                                                    color: hexToColor(
                                                        data.mainColor))),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  if (remove!) {
                                    value.removeArticle(widget.articles);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Article removed',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                } else {
                                  value.saveArticle(widget.articles);
                                  //show snackbar
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Article saved',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              } catch (e) {
                                //show snackbar
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Error saving article',
                                        style: TextStyle(color: Colors.white)),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            }
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: ShapeDecoration(
                              color:
                                  Colors.black.withOpacity(0.07000000029802322),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Center(
                              child: appIcon(
                                value.isArticleSaved(widget.articles)
                                    ? IconsConstants.savefill
                                    : IconsConstants.save,
                                false,
                                context,
                                16,
                                16,
                                color: value.isArticleSaved(widget.articles)
                                    ? hexToColor(data.mainColor)
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            AppInterstitialAd.show();

                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: ShapeDecoration(
                              color:
                                  Colors.black.withOpacity(0.07000000029802322),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Center(
                              child: appIcon(
                                IconsConstants.close,
                                false,
                                context,
                                16,
                                16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),
            Divider(
              height: 1,
              thickness: 2,
              color: Colors.black.withOpacity(0.05000000074505806),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 5),
                itemCount: widget.articles.items!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      if (widget.articles.items![index].type == 'text')
                        Text(
                          widget.articles.items![index].content.toString(),
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 11,
                            fontFamily: 'Abel',
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      else if (widget.articles.items![index].type == 'image')
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(widget
                                  .articles.items![index].content
                                  .toString()),
                              fit: BoxFit.fill,
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
                        ),
                      const SizedBox(height: 16),
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
