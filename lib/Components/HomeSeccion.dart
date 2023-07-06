// ignore_for_file: file_names, non_constant_identifier_names, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:bookshelfapp/Provider/CategorieList.dart';
import 'package:bookshelfapp/Provider/ShearchBooks.dart';
import 'package:bookshelfapp/Theme/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Classes/BookClass.dart';
import '../Pages/BookDetails.dart';
import '../Provider/HomeBooks.dart';
import '../Theme/Colors.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({super.key});

  @override
  Widget build(BuildContext context) {
    final shearch = Provider.of<ShearchProvider>(context, listen: true);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.menu_rounded,
              size: 30,
              color: Colors.black,
            ),
            Text(
              "Home",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage("https://encolombia.com/wp-content/uploads/2021/12/Que-es-paisaje.jpg"),
            )
          ],
        ),
        const SizedBox(height: 20),
        shearch.categorieSelec.categorie.isEmpty
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(color: GREYFIELD, borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  controller: shearch.shearchController,
                  onChanged: (value) => shearch.shearing(value),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.search,
                        color: Colors.black87,
                      ),
                      hintText: "Titles, Authors, or topics"),
                ),
              )
            : Container(
                padding: const EdgeInsets.only(left: 40),
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: () => shearch.clearCategorie(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    )),
              ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class HomeSeccion extends StatelessWidget {
  const HomeSeccion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [CategorieSeccion(), TrendingSeccion(), BookofDaySeccion()],
      ),
    );
  }
}

class CategorieSeccion extends StatelessWidget {
  const CategorieSeccion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final selectCategorie = Provider.of<ShearchProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Categories",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
            height: 240,
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                ...BooksCategorie.map((e) => MaterialButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => selectCategorie.changeSelected(e),
                      child: Container(
                        decoration: BoxDecoration(color: GREYFIELD, borderRadius: BorderRadius.circular(20)),
                        width: e.width,
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [Text(e.categorie), Icon(e.icon)],
                        ),
                      ),
                    ))
              ],
            )),
      ],
    );
  }
}

class TrendingSeccion extends StatelessWidget {
  const TrendingSeccion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final trendingBooks = Provider.of<HomeBooks>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Trending Books",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: double.infinity,
          height: 350,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
            child: trendingBooks.trendingBook.isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: trendingBooks.trendingBook.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      BookHome element = trendingBooks.trendingBook[index];
                      return MaterialButton(
                        onPressed: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) => BookDetails(book_Info: element))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Hero(
                              tag: element.id,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  element.urlImage,
                                  height: 250,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: 170,
                              child: Text(
                                element.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                            SizedBox(
                                width: 170,
                                child: Text(
                                  element.author,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(color: Colors.black54, fontSize: 15),
                                ))
                          ],
                        ),
                      );
                    },
                  )
                : const CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}

class BookofDaySeccion extends StatelessWidget {
  const BookofDaySeccion({super.key});

  @override
  Widget build(BuildContext context) {
    bookAllinfo bookOfDay = Provider.of<HomeBooks>(context, listen: true).bookOfDay;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: SECUNDARY),
          height: 450,
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
            child: bookOfDay.id != ""
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 350,
                            child: Text(
                              bookOfDay.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: themeData.textTheme.titleLarge
                                  ?.copyWith(letterSpacing: 5, fontSize: 25, color: Colors.white),
                            ),
                          ),
                          Text(
                            bookOfDay.author,
                            style: themeData.textTheme.titleLarge
                                ?.copyWith(letterSpacing: 4, fontSize: 15, color: GREYFIELD),
                          ),
                        ],
                      ),
                      MaterialButton(
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BookDetails(
                                  book_Info: BookHome(
                                      title: bookOfDay.title,
                                      urlImage: bookOfDay.urlImage,
                                      author: bookOfDay.author,
                                      id: bookOfDay.id),
                                  description: bookOfDay.description,
                                ))),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white),
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Hero(
                                tag: bookOfDay.id,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    bookOfDay.urlImage,
                                    height: 280,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 180,
                                height: 280,
                                child: Text(
                                  bookOfDay.description,
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 12,
                                  style: themeData.textTheme.bodySmall?.copyWith(fontSize: 16, color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : const CircularProgressIndicator(),
          ),
        ),
        const SizedBox(height: 80)
      ],
    );
  }
}
