import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/news.dart';

class NewsService {
  String url = dotenv.env['NEWS_URL'] ?? 'NO_URL_FOUND';

  Future<void> fetchAndSaveNews() async {
    try {
      final response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        // Decode using UTF-8
        final String responseBody = utf8.decode(response.bodyBytes);

        final List<dynamic> jsonList = jsonDecode(responseBody)['results'];
        final List<Article> newArticles =
            jsonList.map((json) => Article.fromJson(json)).toList();

        // Load existing articles
        List<Article> existingArticles = await loadNewsFromPreferences();

        // Filter out duplicate articles based on a unique identifier
        // Assuming 'id' is a unique identifier in your Article model
        newArticles.removeWhere((newArticle) => existingArticles
            .any((existingArticle) => existingArticle.id == newArticle.id));

        // Combine new and existing articles
        existingArticles.addAll(newArticles);

        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        final String articlesJson = jsonEncode(
            existingArticles.map((article) => article.toJson()).toList());
        await preferences.setString('saved_news', articlesJson);
      } else {
        throw Exception('Failed to load news');
      }
    } catch (error) {
      log('Error fetching news: $error');
    }
  }

  Future<List<Article>> loadNewsFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? articlesJson = prefs.getString('saved_news');

    if (articlesJson != null) {
      final List<dynamic> jsonList = jsonDecode(articlesJson);
      return jsonList.map((json) => Article.fromJson(json)).toList();
    } else {
      return [];
    }
  }
}
