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
  initialize() async {
    news = Provider.of<NewsProvider>(context, listen: false).headline;
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
    return Scaffold(
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
                      errorBuilder: (context, error, stackTrace) => Image.asset(
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
                                    bookMarkNews();
                                  }
                                },
                                icon: Icon(
                                  Icons.bookmark_border,
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
    );
  }

  void bookMarkNews() async {
    try {
      //add into shared preference data
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? jsonData = prefs.getString('bookmark');
      if (jsonData != null) {
        Map<String, dynamic> newsList = jsonDecode(jsonData);
        newsList.forEach((key, value) {
          print(key);
        });
      }

      // //convert the data object into json format
      // var jsonNews = {
      //   'author': news.author,
      //   'title': news.title,
      //   'urlToImage': news.urlToImage,
      //   'content': news.content,
      //   'publishedAt': news.publishedAt.toString(),
      // };
      // prefs.setString('bookmark', jsonEncode(jsonNews));
      // setState(() {
      //   isBookmarked = true;
      // });

      //Provider.of<NewsProvider>(context, listen: false).addBookmark(news);
    } catch (e) {
      print(e);
    }
  }
}
