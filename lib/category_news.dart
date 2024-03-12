import 'package:flutter/material.dart';
import 'package:news/model/headlines.dart';
import 'package:news/provider/news_provider.dart';
import 'package:news/util/api_helper.dart';
import 'package:news/widget/list_of_news.dart';
import 'package:news/widget/progress_indicator.dart';
import 'package:provider/provider.dart';

class CategoryNewsScreen extends StatefulWidget {
  const CategoryNewsScreen({super.key});

  @override
  State<CategoryNewsScreen> createState() => _CategoryNewsScreenState();
}

class _CategoryNewsScreenState extends State<CategoryNewsScreen> {
  List<Headlines> headlines = [];
  bool isLoading = true;
  String cat = '';
  void getNews() async {
    cat = Provider.of<NewsProvider>(context, listen: false).category;
    String url = 'top-headlines?country=in&page=1&pageSize=10&category=$cat';

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
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'Category News',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? MyProgressIndicator(color: Colors.purple, title: 'Loading')
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    child: Text(
                      cat,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  ListOfNews(headlines: headlines),
                ],
              ),
            ),
    );
  }
}
