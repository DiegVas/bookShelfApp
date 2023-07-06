import 'package:bookshelfapp/Pages/Home.dart';
import 'package:bookshelfapp/Provider/ShearchBooks.dart';
import 'package:bookshelfapp/Theme/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Provider/HomeBooks.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider<HomeBooks>(create: (_) => HomeBooks()),
                ChangeNotifierProvider<ShearchProvider>(create: (_) => ShearchProvider())
              ],
              child: const Home(),
            ),
          ),
        ),
      ),
    );
  }
}
