// To parse this JSON data, do
//
//     final firebaseBook = firebaseBookFromJson(jsonString);

import 'dart:convert';

List<FirebaseBook> firebaseBookFromJson(String str) => List<FirebaseBook>.from(
    json.decode(str).map((x) => FirebaseBook.fromJson(x)));

String firebaseBookToJson(List<FirebaseBook> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FirebaseBook {
  String image;
  String publisher;
  String title;
  String authors;
  String bookID;

  FirebaseBook({
    this.image,
    this.publisher,
    this.title,
    this.authors,
    this.bookID,
  });

  factory FirebaseBook.fromJson(Map<String, dynamic> json) => FirebaseBook(
        image: json["image"],
        publisher: json["publisher"] ?? '',
        title: json["title"] ?? '',
        authors: json["authors"] ?? '',
        bookID: json["bookID"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "publisher": publisher,
        "title": title,
        "authors": authors,
        "bookID" : bookID,
      };
}