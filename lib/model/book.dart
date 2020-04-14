// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

Book bookFromJson(String str) => Book.fromJson(json.decode(str));

String bookToJson(Book data) => json.encode(data.toJson());

class Book {
  String kind;
  int totalItems;
  List<Item> items;

  Book({
    this.kind,
    this.totalItems,
    this.items,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        kind: json["kind"] == null ? null : json["kind"],
        totalItems: json["totalItems"] == null ? null : json["totalItems"],
        items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind == null ? null : kind,
        "totalItems": totalItems == null ? null : totalItems,
        "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  String id;
  String etag;
  String selfLink;
  VolumeInfo volumeInfo;

  Item({
    this.id,
    this.etag,
    this.selfLink,
    this.volumeInfo,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"] == null ? null : json["id"],
        etag: json["etag"] == null ? null : json["etag"],
        selfLink: json["selfLink"] == null ? null : json["selfLink"],
        volumeInfo: json["volumeInfo"] == null ? null : VolumeInfo.fromJson(json["volumeInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "etag": etag == null ? null : etag,
        "selfLink": selfLink == null ? null : selfLink,
        "volumeInfo": volumeInfo == null ? null : volumeInfo.toJson(),
      };
}

class VolumeInfo {
  String title;
  List<String> authors;
  String publisher;
  String publishedDate;
  ImageLinks imageLinks;
  String previewLink;
  String subtitle;

  VolumeInfo({
    this.title,
    this.authors,
    this.publisher,
    this.publishedDate,
    this.imageLinks,
    this.previewLink,
    this.subtitle,
  });

  factory VolumeInfo.fromJson(Map<String, dynamic> json) => VolumeInfo(
        title: json["title"] == null ? null : json["title"],
        authors: json["authors"] == null ? null : List<String>.from(json["authors"].map((x) => x)),
        publisher: json["publisher"] == null ? null : json["publisher"],
        imageLinks: json["imageLinks"] == null ? null : ImageLinks.fromJson(json["imageLinks"]),
        previewLink: json["previewLink"] == null ? null : json["previewLink"],
        subtitle: json["subtitle"] == null ? null : json["subtitle"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "authors": authors == null ? null : List<dynamic>.from(authors.map((x) => x)),
        "publisher": publisher == null ? null : publisher,
        "imageLinks": imageLinks == null ? null : imageLinks.toJson(),
        "previewLink": previewLink == null ? null : previewLink,
        "subtitle": subtitle == null ? null : subtitle,
        "previewLink": previewLink == null ? null : previewLink,
      };
}

class ImageLinks {
  String smallThumbnail;
  String thumbnail;

  ImageLinks({
    this.smallThumbnail,
    this.thumbnail,
  });

  factory ImageLinks.fromJson(Map<String, dynamic> json) => ImageLinks(
        smallThumbnail: json["smallThumbnail"] == null ? null : json["smallThumbnail"],
        thumbnail: json["thumbnail"] == null ? null : json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "smallThumbnail": smallThumbnail == null ? null : smallThumbnail,
        "thumbnail": thumbnail == null ? null : thumbnail,
      };
}
