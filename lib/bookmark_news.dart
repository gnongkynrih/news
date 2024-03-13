import 'package:flutter/material.dart';
import 'package:news/model/headlines.dart';
import 'package:news/provider/news_provider.dart';
import 'package:news/widget/list_of_news.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  String isloading = 'load';
  List<Headlines> bookmarkList = [];
  getBookmarkNews() async {
    var provider = Provider.of<NewsProvider>(context, listen: false);

    for (var article in provider.listNews) {
      bookmarkList.add(Headlines.fromJSON(article));
    }

    if (bookmarkList.isEmpty) {
      // if no news is bookmarked
      setState(() {
        isloading = 'no-record';
      });
      return;
    }
    setState(() {
      isloading = 'stop';
    });
  }

  @override
  void initState() {
    getBookmarkNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'Bookmark',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: showData(),
    );
  }

  Widget showData() {
    switch (isloading) {
      case 'load':
        return const Center(child: CircularProgressIndicator());
      case 'no-record':
        return const Center(
          child: Text('No bookmark news yet'),
        );
      default:
        return ListOfNews(headlines: bookmarkList);
    }
  }
}
