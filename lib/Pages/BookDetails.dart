// ignore_for_file: file_names, must_be_immutable, non_constant_identifier_names

import 'dart:ui';

import 'package:bookshelfapp/Classes/BookClass.dart';
import 'package:bookshelfapp/Provider/BookId.dart';
import 'package:bookshelfapp/Theme/Colors.dart';
import 'package:bookshelfapp/Theme/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetails extends StatelessWidget {
  BookHome book_Info;
  String? description;
  BookDetails({super.key, required this.book_Info, this.description});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => BookId(book_Info.id, description),
        builder: (context, snapshot) {
          final info = Provider.of<BookId>(context);
          return Scaffold(
            body: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          book_Info.urlImage,
                        ),
                        fit: BoxFit.cover)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: PRIMARY.withOpacity(.3),
                      ),
                      ScrollConfiguration(
                        behavior: const ScrollBehavior().copyWith(overscroll: false),
                        child: SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.only(top: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 40),
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      icon: const Icon(
                                        Icons.arrow_back_ios_new,
                                        color: Colors.white,
                                      )),
                                ),
                                const SizedBox(height: 20),
                                Hero(
                                  tag: book_Info.id,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      book_Info.urlImage,
                                      height: 320,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 60),
                                  child: Text(
                                    book_Info.title,
                                    textAlign: TextAlign.center,
                                    style: themeData.textTheme.titleLarge
                                        ?.copyWith(letterSpacing: 5, fontSize: 35, color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  book_Info.author,
                                  style: themeData.textTheme.titleSmall?.copyWith(color: Colors.white.withOpacity(.6)),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                    constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 500),
                                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(90))),
                                    child: AnimatedSwitcher(
                                      duration: const Duration(milliseconds: 500),
                                      transitionBuilder: (child, animation) => FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      ),
                                      child: info.description != ""
                                          ? Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 20),
                                                Text(
                                                  "Description",
                                                  style: themeData.textTheme.titleLarge,
                                                ),
                                                const SizedBox(height: 20),
                                                Text(
                                                  info.description
                                                      .replaceAll("<p>", "")
                                                      .replaceAll("</p>", "")
                                                      .replaceAll("<i>", "")
                                                      .replaceAll("</i>", "")
                                                      .replaceAll("<br>", "")
                                                      .replaceAll("</br>", ""),
                                                  textAlign: TextAlign.justify,
                                                  style: themeData.textTheme.bodySmall,
                                                )
                                              ],
                                            )
                                          : CircularProgressIndicator(
                                              color: PRIMARY,
                                            ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
