// ignore_for_file: prefer_const_constructors, avoid_relative_lib_imports, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:instagram_new/ui/maintab.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'instagram_new',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.white,
        ),
        primaryColor: Colors.white,
      ),
      home: MainTabPage(),
    );
  }
}
