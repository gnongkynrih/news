import 'package:flutter/material.dart';
import 'package:news/category_news.dart';
import 'package:news/provider/news_provider.dart';
import 'package:news/util/api_helper.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final keyForm = GlobalKey<FormState>();

  void goSearchNews(String query) {
    String url = '/everything?q=$query&page=1&pageSize=10';
    var data = ApiHelper.get(url);
  }

  List<String> categories = [];
  @override
  void initState() {
    categories = Provider.of<NewsProvider>(context, listen: false).categories;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text(
            'Search',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Form(
                key: keyForm,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        onFieldSubmitted: (value) {
                          if (value.isEmpty) return;
                          goSearchNews(value);
                        },
                        decoration: const InputDecoration(
                          labelText: 'Search',
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Categories'),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 100,
                        child: ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(categories[index]),
                                trailing: IconButton(
                                  onPressed: () {
                                    Provider.of<NewsProvider>(context,
                                            listen: false)
                                        .setCategory(categories[index]);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const CategoryNewsScreen(),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.arrow_forward_ios),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ))
          ]),
        ));
  }
}
