// ignore_for_file: empty_constructor_bodies, file_names, camel_case_types

class BookHome {
  String title;
  String author;
  String urlImage;
  String id;
  BookHome({required this.title, required this.urlImage, required this.author, required this.id});
}

class bookAllinfo {
  String title;
  String urlImage;
  String id;
  String author;
  String description;
  bookAllinfo(
      {required this.title, required this.urlImage, required this.id, required this.author, required this.description});
}
