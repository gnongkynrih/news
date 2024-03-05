import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static String key = dotenv.env['NEWS_API_KEY']!;
  static String baseUrl = 'https://newsapi.org/v2/';

  static Future<Map<String, dynamic>> get(String url) async {
    String path = '$baseUrl$url&apiKey=$key';

    var response = await http.get(Uri.parse(path));
    return jsonDecode(response.body);
  }
}
