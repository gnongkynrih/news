import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news/model/headlines.dart';
import 'package:news/provider/news_provider.dart';
import 'package:news/util/api_helper.dart';
import 'package:news/widget/category_list.dart';
import 'package:news/widget/my_drawer.dart';
import 'package:news/widget/news_card.dart';
import 'package:news/widget/progress_indicator.dart';
import 'package:news/widget/vertical_list_card.dart';
import 'package:provider/provider.dart';

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
      headlines.add(Headlines.fromJSON(article));
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
      drawer: const MyDrawer(),
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
                const CategoryListWidget(),
                const SizedBox(
                  height: 15,
                ),
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
                    height: 150,
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
                SizedBox(
                  height: 400,
                  child: ListView.builder(
                      itemCount: headlines.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return VerticalListCard(headline: headlines[index]);
                      }),
                ),
              ]),
      ),
    );
  }
}
