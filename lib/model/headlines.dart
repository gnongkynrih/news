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
}
