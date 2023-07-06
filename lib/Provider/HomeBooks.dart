// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:bookshelfapp/Api/Credentials.dart';
import 'package:bookshelfapp/Classes/BookClass.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String letters = "abcdefghijklmnopqrstuvwxyz";

class HomeBooks extends ChangeNotifier {
  List<BookHome> trendingBook = [];
  bookAllinfo bookOfDay = bookAllinfo(title: "", urlImage: "", id: "", author: "", description: "");

  Future<void> gettrendigBook() async {
    final Uri uri = Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?&sorting=relevance&maxResult=10&q=subject:science fiction&key=$api_key");
    final response = await http.get(uri);
    if (response.statusCode != 200) return print("Algo ocurrio mal");
    final decodedData = json.decode(response.body);
    final List<dynamic> books = decodedData["items"];
    trendingBook = books
        .map(
          (e) => BookHome(
              title: e["volumeInfo"]["title"],
              author: e["volumeInfo"]["authors"][0],
              urlImage: e["volumeInfo"]["imageLinks"] == null
                  ? "https://static.vecteezy.com/system/resources/thumbnails/024/551/617/small/gardening-houseplant-error-404-flash-message-environmental-friendly-watering-plant-empty-state-ui-design-page-not-found-popup-cartoon-image-flat-illustration-concept-on-white-background-vector.jpg"
                  : e["volumeInfo"]["imageLinks"]["thumbnail"],
              id: e["id"]),
        )
        .toList();
    notifyListeners();
  }

  Future<void> getBookofDay() async {
    String letter = letters.split("")[Random().nextInt(letters.length)];
    final Uri uri = Uri.parse("https://www.googleapis.com/books/v1/volumes?q=$letter&maxResults=1&key=$api_key");
    final response = await http.get(uri);
    if (response.statusCode != 200) return print("Algo ocurrio mal");
    final decodedData = json.decode(response.body);
    final List<dynamic> books = decodedData["items"];
    bookOfDay = bookAllinfo(
        title: books[0]["volumeInfo"]["title"],
        urlImage: books[0]["volumeInfo"]["imageLinks"] == null
            ? "https://static.vecteezy.com/system/resources/thumbnails/024/551/617/small/gardening-houseplant-error-404-flash-message-environmental-friendly-watering-plant-empty-state-ui-design-page-not-found-popup-cartoon-image-flat-illustration-concept-on-white-background-vector.jpg"
            : books[0]["volumeInfo"]["imageLinks"]["thumbnail"],
        id: books[0]["id"],
        author: books[0]["volumeInfo"]["authors"][0],
        description: books[0]["volumeInfo"]["description"] ?? "");
    notifyListeners();
  }
}
