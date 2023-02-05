// ignore_for_file: prefer_const_constructors, avoid_relative_lib_imports, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:instagram_new/ui/maintab.dart';
import 'package:instagram_new/viewmodel/theme_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final themeViewModel = Get.put(ThemeViewModel());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeViewModel>(
      builder: (tx) {
        return GetMaterialApp(
          title: 'instagram_new',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              color: tx.themeColor,
              elevation: 0,
              iconTheme: IconThemeData(
                color: tx.themeTextColor,
              ),
              titleTextStyle: TextStyle(
                color: tx.themeTextColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            textTheme: TextTheme(
              // bodyText1: TextStyle(),
              // bodyText2: TextStyle(),
              displayLarge: TextStyle(),
              displayMedium: TextStyle(),
              displaySmall: TextStyle(),
              headlineLarge: TextStyle(),
              headlineMedium: TextStyle(),
              headlineSmall: TextStyle(),
              titleLarge: TextStyle(),
              titleMedium: TextStyle(),
              titleSmall: TextStyle(),
              bodyLarge: TextStyle(),
              bodyMedium: TextStyle(),
              bodySmall: TextStyle(),
            ).apply(
              bodyColor: tx.themeTextColor,
              // displayColor: Colors.blue,
            ),
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: TextStyle(fontSize: 12.0),
              suffixStyle: TextStyle(color: Colors.white),
              prefixStyle: TextStyle(color: Colors.white),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: tx.themeTextColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: tx.themeTextColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: tx.themeTextColor,
                ),
              ),
            ),
            canvasColor: tx.themeColor,
            primaryColor: Colors.black,
            iconTheme: IconThemeData(
              color: tx.themeTextColor,
            ),
          ),
          home: MainTabPage(),
        );
      },
    );
  }
}
