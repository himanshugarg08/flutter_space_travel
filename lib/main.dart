import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mars/first_page.dart/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Mars',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
