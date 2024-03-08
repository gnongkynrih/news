import 'package:flutter/material.dart';
import 'package:news/model/headlines.dart';
import 'package:news/provider/news_provider.dart';
import 'package:provider/provider.dart';

class VerticalListCard extends StatefulWidget {
  VerticalListCard({super.key, required this.headline});
  Headlines headline;
  @override
  State<VerticalListCard> createState() => _VerticalListCardState();
}

class _VerticalListCardState extends State<VerticalListCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<NewsProvider>(context, listen: false)
            .setHeadline(widget.headline);
        Navigator.pushNamed(context, 'detailnews');
      },
      child: ListTile(
        title: Text(widget.headline.title),
        subtitle: Text('By ${widget.headline.author}'),
        trailing: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(widget.headline.urlToImage!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                    'images/noimage.png',
                    fit: BoxFit.cover,
                  )),
        ),
      ),
    );
  }
}
