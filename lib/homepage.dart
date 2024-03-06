import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news/model/headlines.dart';
import 'package:news/util/api_helper.dart';
import 'package:news/widget/news_card.dart';
import 'package:news/widget/progress_indicator.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  bool isLoading = true;
  List<Headlines> headlines = [];

  void getNews() async {
    String url = 'top-headlines?country=in&page=1&pageSize=10';

    var data = await ApiHelper.get(url);

    for (var article in data['articles']) {
      headlines.add(Headlines(
          content: data['content'],
          author: article['author'] ??
              '', //if author is null then assign empty string
          title: article['title'] ?? '',
          urlToImage: article['urlToImage'],
          publishedAt: DateTime.parse(
            article['publishedAt'],
          )));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'My News App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: isLoading
            ? Center(
                child: MyProgressIndicator(
                color: Colors.red,
                title: "Loading data... Please wait",
              ))
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text(
                  'HEADLINES',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SizedBox(
                    height: 200,
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: headlines.length,
                      itemBuilder: (context, index) {
                        return NewsCard(headline: headlines[index]);
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ]),
      ),
    );
  }
}
