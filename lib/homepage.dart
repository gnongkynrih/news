import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news/util/api_helper.dart';
import 'package:news/widget/progress_indicator.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  bool isLoading = true;
  int totalNews = 0;
  void getNews() async {
    String url = 'top-headlines?country=in';

    var data = await ApiHelper.get(url);
    setState(() {
      isLoading = false;
    });
    setState(() {
      totalNews = data['totalResults'];
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
            : Text("Total Headlines : $totalNews"),
      ),
    );
  }
}
