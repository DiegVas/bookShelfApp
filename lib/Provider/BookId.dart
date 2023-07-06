// ignore_for_file: file_names, duplicate_ignore, avoid_print

import 'dart:convert';
import 'package:bookshelfapp/Api/Credentials.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookId extends ChangeNotifier {
  String description = "";
  Future<void> gettrendigBook(String id) async {
    final Uri uri = Uri.parse("https://www.googleapis.com/books/v1/volumes/$id?key=$api_key");
    final response = await http.get(uri);
    if (response.statusCode != 200) return print("Algo ocurrio mal");
    final decodedData = json.decode(response.body);
    final books = decodedData;

    description = books["volumeInfo"]["description"];
    notifyListeners();
  }

  BookId(String id, String? des) {
    if (des != null) {
      description = des;
      return;
    }
    gettrendigBook(id);
  }
}
