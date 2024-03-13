import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news/model/headlines.dart';
import 'package:news/provider/news_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailPageScreen extends StatefulWidget {
  const DetailPageScreen({super.key});

  @override
  State<DetailPageScreen> createState() => _DetailPageScreenState();
}

class _DetailPageScreenState extends State<DetailPageScreen> {
  late Headlines news;
  bool isLoading = true;
  bool isBookmarked = false;

  late SharedPreferences prefs;
  initialize() async {
    var provider = Provider.of<NewsProvider>(context, listen: false);
    news = provider.headline;

    prefs = await SharedPreferences.getInstance();

    //check if the news is bookmarked, if so then highlight the bookmark icon
    for (Map<String, dynamic> article in provider.listNews) {
      if (article['title'] == news.title) {
        setState(() {
          isBookmarked = true;
          isLoading = false;
        });
        return;
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.purple,
          title: const Text(
            'News',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Image.network(
                        news.urlToImage!,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          'images/noimage.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              news.title,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'By ${news.author}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (isBookmarked == false) {
                                      addBookMark();
                                    } else {
                                      removeBookMark();
                                    }
                                  },
                                  icon: Icon(
                                    Icons.bookmark,
                                    color:
                                        isBookmarked ? Colors.red : Colors.grey,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                'Published on ${news.publishedAt.toString().substring(0, 10)}',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              news.content,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        )),
                  ],
                ),
        ),
      ),
    );
  }

  void removeBookMark() {
    var provider = Provider.of<NewsProvider>(context, listen: false);
    provider.listNews.removeWhere((element) => element['title'] == news.title);
    prefs.setString('bookmark', jsonEncode(provider.listNews));
    setState(() {
      isBookmarked = false;
    });
  }

  void addBookMark() async {
    var provider = Provider.of<NewsProvider>(context, listen: false);
    try {
      var jsonNews = {
        'author': news.author,
        'title': news.title,
        'urlToImage': news.urlToImage,
        'content': news.content,
        'publishedAt': news.publishedAt.toString(),
      };
      provider.listNews.add(jsonNews);
      await prefs.setString('bookmark', jsonEncode(provider.listNews));
      setState(() {
        isBookmarked = true;
      });
    } catch (e) {
      print(e);
    }
  }
}
