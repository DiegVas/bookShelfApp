// ignore_for_file: file_names, non_constant_identifier_names
import 'package:bookshelfapp/Pages/BookDetails.dart';
import 'package:bookshelfapp/Provider/ShearchBooks.dart';
import 'package:bookshelfapp/Theme/Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Classes/BookClass.dart';

class ShearPage extends StatelessWidget {
  const ShearPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ShearchP = Provider.of<ShearchProvider>(context, listen: true);
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
          itemCount: ShearchP.findBooks.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            BookHome book = ShearchP.findBooks[index];
            return MaterialButton(
                onPressed: () =>
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BookDetails(book_Info: book))),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: GREYFIELD),
                        height: 150,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Hero(
                              tag: book.id,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  book.urlImage,
                                  height: 180,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    Text(
                                      book.title,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.labelMedium,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      book.author,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(color: Colors.black54, fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          },
        ))
      ],
    );
  }
}

class FilterbyCategories extends StatelessWidget {
  const FilterbyCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final ShearchP = Provider.of<ShearchProvider>(context, listen: true);
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
          itemCount: ShearchP.filterBook.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            BookHome book = ShearchP.filterBook[index];
            return MaterialButton(
                onPressed: () =>
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BookDetails(book_Info: book))),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: GREYFIELD),
                        height: 150,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Hero(
                              tag: book.id,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  book.urlImage,
                                  height: 160,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    Text(
                                      book.title,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.labelMedium,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      book.author,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(color: Colors.black54, fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          },
        ))
      ],
    );
  }
}
