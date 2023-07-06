// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Classes/CategorieClass.dart';

List<Categories> BooksCategorie = [
  Categories(categorie: "Adventure stories", icon: FontAwesomeIcons.khanda, width: 180),
  Categories(categorie: "Classics", icon: Icons.book, width: 150),
  Categories(categorie: "Fantasy", icon: FontAwesomeIcons.hatWizard, width: 130),
  Categories(categorie: "Romance", icon: FontAwesomeIcons.heart, width: 130),
  Categories(categorie: "War", icon: FontAwesomeIcons.gun, width: 100),
  Categories(categorie: "Mystery", icon: FontAwesomeIcons.question, width: 140),
  Categories(categorie: "Horror", icon: FontAwesomeIcons.skull, width: 140),
  Categories(categorie: "Crime", icon: FontAwesomeIcons.handcuffs, width: 120),
  Categories(categorie: "Historical fiction", icon: FontAwesomeIcons.landmark, width: 180)
];
