import 'package:flutter/material.dart';

class RectangleBackgroundText extends StatelessWidget {
  RectangleBackgroundText({Key? key, required this.tag}) : super(key: key);
  String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(3))),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      child: Text(
        tag,
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }
}
