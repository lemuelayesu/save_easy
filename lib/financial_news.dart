import 'package:flutter/material.dart';
import 'package:save_easy/screens/news_webview.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({
    super.key,
    required this.headlineImage,
    required this.headlineText,
    required this.newsSource,
    required this.url,
  });

  final String headlineImage;
  final String headlineText;
  final String newsSource;
  final String url;

  //so the user can click on any article and it'll it up in one of those browser thinies
  //And if they click see all, it should open move everything out of the way but keep the save Now button at the top of the screen
  //and the user can scroll past it to check of the news feed.
  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return NewsWebview(url: url);
        },),);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: Container(
              height: 100.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: color.surface,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 110,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: Image.network(
                        //headline image
                        headlineImage,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //article
                          Text(
                            headlineText,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: color.onSurface,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                          //source
                          Text(
                            newsSource,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: color.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
