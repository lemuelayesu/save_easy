import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:save_easy/services/news_service.dart';

import '../financial_news.dart';
import '../models/news.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'News Feed',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color.onSurface,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: FutureBuilder(
          future: NewsService().loadNewsFromPreferences(),
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            } else if (snapshots.hasError) {
              log('Error: ${snapshots.hasError}');
              return const SizedBox();
            } else if (snapshots.hasData) {
              List<Article> articles = snapshots.data ?? [];
              return ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  Article article = articles[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: NewsTile(
                      headlineImage: article.imageUrl,
                      headlineText: article.title,
                      newsSource: article.source,
                      url: article.articleUrl,
                    ),
                  );
                },
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
