import 'package:flutter/material.dart';
import 'package:galary_app/fullimage.dart';
import 'package:galary_app/walpapers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wallpapers(),
      debugShowCheckedModeBanner: false,
      routes: {'fullImages': (context) => FullImage()},
    );
  }
}
