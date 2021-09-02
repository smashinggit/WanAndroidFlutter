// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

void main() async {
  print("getDataStart");
  getData().then((value) {
    print("getCompete $value");
  }).catchError((e){
    print("catchError $e");
  });
}

Future getData() async {
  return Future.delayed(const Duration(seconds: 2), () {
    return 2;
  });
}
