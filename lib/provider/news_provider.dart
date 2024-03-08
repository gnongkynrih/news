import 'package:flutter/material.dart';
import 'package:news/model/headlines.dart';

class NewsProvider with ChangeNotifier {
  late Headlines headline;
  List<String> categories = [
    'Business',
    'Entertainment',
    'General',
    'Health',
    'Science',
    'Sports',
    'Technology'
  ];

  String category = '';
  void setHeadline(Headlines news) {
    headline = news;
    notifyListeners();
  }

  void setCategory(String cat) {
    category = cat;
    notifyListeners();
  }
}
