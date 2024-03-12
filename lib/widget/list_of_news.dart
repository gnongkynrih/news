import 'package:flutter/material.dart';
import 'package:news/model/headlines.dart';
import 'package:news/provider/news_provider.dart';
import 'package:provider/provider.dart';

class ListOfNews extends StatelessWidget {
  const ListOfNews({
    super.key,
    required this.headlines,
  });

  final List<Headlines> headlines;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 100,
      child: ListView.builder(
        itemCount: headlines.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Provider.of<NewsProvider>(context, listen: false)
                  .setHeadline(headlines[index]);
              Navigator.pushNamed(context, 'detailnews');
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              child: ListTile(
                leading: SizedBox(
                  width: 100,
                  child: Image.network(
                    headlines[index].urlToImage!,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      'images/noimage.png',
                      fit: BoxFit.cover,
                    ),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  headlines[index].title,
                ),
                subtitle: Text(
                  'By ${headlines[index].author}',
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
