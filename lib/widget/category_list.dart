import 'package:flutter/material.dart';
import 'package:news/category_news.dart';
import 'package:news/provider/news_provider.dart';
import 'package:provider/provider.dart';

class CategoryListWidget extends StatefulWidget {
  const CategoryListWidget({super.key});

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  List<String> newsCategory = [];
  @override
  void initState() {
    newsCategory = Provider.of<NewsProvider>(context, listen: false).categories;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: ListView.builder(
        itemCount: newsCategory.length,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Provider.of<NewsProvider>(context, listen: false)
                    .setCategory(newsCategory[index]);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoryNewsScreen(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    newsCategory[index],
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
