import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guid/model/data.dart';
import 'package:guid/model_view/data_provider.dart';
import 'package:guid/utils/colors_utils.dart';
import 'package:guid/view/home/home.dart';

Container articlItem(BuildContext context, List<Articles> allArticles,
    int index, DataProvider value) {
  return Container(
    height: 100,
    margin: const EdgeInsets.only(bottom: 18),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Stack(
      children: [
        InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ArticleDetails(
            //       article: allArticles[index],
            //     ),
            //   ),
            // );
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                '→',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 15,
                  fontFamily: 'Abel',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(allArticles[index].icon.toString()),
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
            ),
            const SizedBox(
              width: 8,
            ),
            SizedBox(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        allArticles[index].title.toString(),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.visible,
                        style: GoogleFonts.museoModerno(
                          color: hexToColor(value.data.mainColor.toString()),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      // child: Text(
                      //   allArticles[index]
                      //       .shortTitle
                      //       .toString(),
                      //   maxLines: 3,
                      //   textAlign: TextAlign.justify,
                      //   overflow: TextOverflow.ellipsis,
                      //   style: TextStyle(
                      //     color: Colors.black.withOpacity(0.5),
                      //     fontSize: 11,
                      //     fontFamily: 'Abel',
                      //     fontWeight: FontWeight.w400,
                      //   ),
                      // ),
                      child: TruncatedText(
                        text: allArticles[index].shortTitle.toString(),
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 11,
                          fontFamily: 'Abel',
                          fontWeight: FontWeight.w400,
                        ),
                        maxHeight:
                            80.0, // Adjust based on your line height and font size
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
