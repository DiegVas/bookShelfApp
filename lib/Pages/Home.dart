// ignore_for_file: file_names
import 'package:bookshelfapp/Components/HomeSeccion.dart';
import 'package:bookshelfapp/Pages/ShareBook.dart';
import 'package:bookshelfapp/Provider/HomeBooks.dart';
import 'package:bookshelfapp/Provider/ShearchBooks.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeBooks>(context, listen: false)
      ..gettrendigBook()
      ..getBookofDay();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ShearchProvider>(context, listen: true);
    return Column(
      children: [
        const HeaderHome(),
        Expanded(
          child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
              child: controller.shearchController.text.isEmpty
                  ? controller.categorieSelec.categorie.isEmpty
                      ? const HomeSeccion()
                      : const FilterbyCategories()
                  : const ShearPage()),
        )
      ],
    );
  }
}
