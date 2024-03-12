import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Headlines {
  String author;
  String title;
  String? urlToImage;
  String content;
  DateTime publishedAt;
  Headlines({
    required this.author,
    required this.title,
    this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Headlines.fromJSON(Map<String, dynamic> article) {
    return Headlines(
        author: article['author'] ?? '',
        title: article['title'] ?? '',
        urlToImage: article['urlToImage'] ?? '',
        content: article['content'] ?? '',
        publishedAt: DateTime.parse(article['publishedAt']));
  }

  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'title': title,
      'urlToImage': urlToImage,
      'content': content,
      'publishedAt': publishedAt.toIso8601String(),
    };
  }
}
