import 'package:flutter/material.dart';
import 'package:news/model/headlines.dart';

class NewsCard extends StatefulWidget {
  NewsCard({super.key, required this.headline});
  Headlines headline;
  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Stack(
        children: [
          SizedBox(
            height: 150,
            width: MediaQuery.of(context).size.width - 100,
            child: widget.headline.urlToImage == null
                ? Image.asset('images/noimage.png')
                : Image.network(
                    widget.headline.urlToImage!,
                    errorBuilder: (context, error, stackTrace) =>
                        Image.asset('images/noimage.png'),
                    fit: BoxFit.fill,
                  ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              color: Colors.black.withOpacity(.4),
              height: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.headline.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Publised on ${widget.headline.publishedAt.toString().substring(0, 10)}',
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
