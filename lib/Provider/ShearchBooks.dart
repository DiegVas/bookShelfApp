// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import 'package:bookshelfapp/Classes/BookClass.dart';
import 'package:bookshelfapp/Classes/CategorieClass.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Api/Credentials.dart';

class ShearchProvider with ChangeNotifier {
  TextEditingController shearchController = TextEditingController();
  List<BookHome> findBooks = [];
  Future<void> shearing(String value) async {
    shearchController.text = value;
    notifyListeners();
    await getShearchBook();
  }

  Categories categorieSelec = Categories(categorie: "", icon: Icons.abc, width: 100);
  List<BookHome> filterBook = [];

  Future<void> getShearchBook() async {
    if (shearchController.text.isEmpty) return;
    final Uri uri = Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?&sorting=relevance&maxResult=10&q=${shearchController.text}&key=$api_key");
    final response = await http.get(uri);
    if (response.statusCode != 200) return print("Algo ocurrio mal");
    final decodedData = json.decode(response.body);
    final List<dynamic> books = decodedData["items"];
    findBooks = books
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

  Future<void> changeSelected(Categories newCat) async {
    categorieSelec = Categories(categorie: newCat.categorie, icon: newCat.icon, width: 0);
    notifyListeners();
    await getfilterBooks();
  }

  void clearCategorie() {
    categorieSelec.categorie = "";
    filterBook = [];
    notifyListeners();
  }

  Future<void> getfilterBooks() async {
    final Uri uri = Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?&sorting=relevance&maxResult=10&q=subject:${categorieSelec.categorie}&key=$api_key");
    final response = await http.get(uri);
    if (response.statusCode != 200) return print("Algo ocurrio mal");
    final decodedData = json.decode(response.body);
    final List<dynamic> books = decodedData["items"];
    filterBook = books
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
}
