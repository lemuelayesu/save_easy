class Article {
  final String title;
  final String source;
  final String date;
  final String imageUrl;
  final String articleId;
  final String articleUrl;
  final String description;

  Article({
    required this.title,
    required this.source,
    required this.date,
    required this.imageUrl,
    required this.articleId,
    required this.articleUrl,
    required this.description,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] as String? ?? 'No Title',
      source: json['source_name'] as String? ?? 'Unknown Source',
      date: json['pubDate'] as String? ?? 'Unknown Date',
      imageUrl: json['image_url'] as String? ?? '',
      articleId: json['article_id'] as String? ?? 'Unknown ID',
      articleUrl: json['link'] as String? ?? '',
      description: json['description'] as String? ?? 'No Description',
    );
  }

  get id => null;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'source_name': source,
      'pubDate': date,
      'image_url': imageUrl,
      'article_id': articleId,
      'link': articleUrl,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'Article(title: $title, source: $source, date: $date, imageUrl: $imageUrl, articleId: $articleId, articleUrl: $articleUrl, description: $description)';
  }
}
