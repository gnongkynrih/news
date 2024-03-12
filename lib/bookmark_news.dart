import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  String isloading = 'load';

  getBookmarkNews() async {
    // get bookmarked news from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('bookmark');
    if (data == null) {
      // if no news is bookmarked
      setState(() {
        isloading = 'no-record';
      });
      return;
    }
    setState(() {
      isloading = 'stop';
    });
    Map<String, dynamic> news = jsonDecode(data);
    news.forEach((key, value) {
      print(key);
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
        return const Text('Bookmark news here');
    }
  }
}
