import 'package:flutter/material.dart';

class MyProgressIndicator extends StatefulWidget {
  MyProgressIndicator({super.key, required this.color, required this.title});
  Color color;
  String title;
  @override
  State<MyProgressIndicator> createState() => _MyProgressIndicatorState();
}

class _MyProgressIndicatorState extends State<MyProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            color: widget.color,
          ),
          const SizedBox(width: 10),
          Text(widget.title),
        ],
      ),
    );
  }
}
