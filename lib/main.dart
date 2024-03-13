import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:news/bookmark_news.dart';
import 'package:news/detail_page.dart';
import 'package:news/homepage.dart';
import 'package:news/provider/news_provider.dart';
import 'package:news/search.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NewsProvider(),
        ),
      ],
      child: const News(),
    ),
  );
}

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> with SingleTickerProviderStateMixin {
  late TabController tabController;
  int _currentIndex =
      0; //store which menu you selected from bottom navigation bar

  void readBookMarkData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? jsonData = pref.getString('bookmark');
    if (jsonData != null) {
      List<dynamic> data = jsonDecode(jsonData);
      for (Map<String, dynamic> article in data) {
        Provider.of<NewsProvider>(context, listen: false).listNews.add(article);
      }
    }
    FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    tabController =
        TabController(length: 3, vsync: this, initialIndex: _currentIndex);
    readBookMarkData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const HomePageScreen(),
      home: Scaffold(
        body: TabBarView(
          controller: tabController,
          children: const [
            HomePageScreen(),
            BookmarkScreen(),
            SearchScreen(),
            // HomePageScreen(),
          ],
        ),
        bottomNavigationBar: SalomonBottomBar(
          backgroundColor: Colors.grey.shade200,
          currentIndex: _currentIndex,
          onTap: (tabIndex) {
            setState(() => _currentIndex = tabIndex);
            tabController.animateTo(_currentIndex);
          },
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text("Home"),
              selectedColor: Colors.purple,
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: const Icon(Icons.bookmark_border),
              title: const Text("Bookmark"),
              selectedColor: Colors.pink,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: const Icon(Icons.search),
              title: const Text("Search"),
              selectedColor: Colors.orange,
            ),

            /// Profile
            // SalomonBottomBarItem(
            //   icon: const Icon(Icons.person),
            //   title: const Text("Profile"),
            //   selectedColor: Colors.teal,
            // ),
          ],
        ),
      ),
      routes: {
        'home': (context) => const HomePageScreen(),
        'search': (context) => const SearchScreen(),
        'detailnews': (context) => const DetailPageScreen(),
      },
    );
  }
}
