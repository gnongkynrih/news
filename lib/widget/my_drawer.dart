import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('images/noimage.png'),
        ),
        const Divider(
          color: Colors.purple,
        ),
        ListTile(
          title: const Text('Home'),
          leading: const Icon(Icons.home),
          onTap: () {
            Navigator.pushNamed(context, 'home');
          },
        ),
        ListTile(
          title: const Text('Category'),
          leading: const Icon(Icons.category),
          onTap: () {
            Navigator.pushNamed(context, 'category');
          },
        ),
        ListTile(
          title: const Text('Search'),
          leading: const Icon(Icons.search),
          onTap: () {
            Navigator.pushNamed(context, 'search');
          },
        ),
      ]),
    );
  }
}
