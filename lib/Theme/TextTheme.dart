// ignore_for_file: file_names, unused_element

import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
    fontFamily: "Open Sans",
    textSelectionTheme: const TextSelectionThemeData(selectionHandleColor: Colors.black87, cursorColor: Colors.black),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontFamily: "Oswald", fontWeight: FontWeight.w600, fontSize: 30),
      titleSmall: TextStyle(fontFamily: "Oswald", fontWeight: FontWeight.normal, fontSize: 25),
      bodySmall: TextStyle(fontFamily: "Open Sans", fontWeight: FontWeight.normal, fontSize: 20),
      labelMedium: TextStyle(fontFamily: "Open Sans", fontWeight: FontWeight.w600, fontSize: 18),
    ));
