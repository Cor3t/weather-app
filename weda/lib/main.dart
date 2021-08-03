import 'package:flutter/material.dart';
import 'package:weda/screen/search_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: SearchPage(),
    );
  }
}
