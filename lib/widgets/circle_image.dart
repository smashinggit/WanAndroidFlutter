import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  CircleImage({Key? key, required this.path, required this.width})
      : super(key: key);

  String path = "";
  double width = 80;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        path,
        width: width,
        height: width,
        fit: BoxFit.cover,
      ),
    );
  }
}
