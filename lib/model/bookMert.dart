// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';


class Welcome {
  final String kind;
  final String id;
  final String etag;
  final VolumeInfo volumeInfo;

  Welcome({
    @required this.kind,
    @required this.id,
    @required this.etag,
    @required this.volumeInfo,
  });

  factory Welcome.fromJson(String str) => Welcome.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Welcome.fromMap(Map<String, dynamic> json) => Welcome(
    kind: json["kind"],
    id: json["id"],
    etag: json["etag"],
    volumeInfo: VolumeInfo.fromMap(json["volumeInfo"]),
  );

  Map<String, dynamic> toMap() => {
    "kind": kind,
    "id": id,
    "etag": etag,
    "volumeInfo": volumeInfo.toMap(),
  };
}

class VolumeInfo {
  final String title;
  final List<String> authors;
  final String publisher;
  final String description;
  final ReadingModes readingModes;
  final int pageCount;
  final String printType;
  final List<String> categories;
  final ImageLinks imageLinks;
  final String language;
  final String previewLink;
  final String infoLink;
  final String canonicalVolumeLink;

  VolumeInfo({
    @required this.title,
    @required this.authors,
    @required this.publisher,
    @required this.description,
    @required this.readingModes,
    @required this.pageCount,
    @required this.printType,
    @required this.categories,
    @required this.imageLinks,
    @required this.language,
    @required this.previewLink,
    @required this.infoLink,
    @required this.canonicalVolumeLink,
  });

  factory VolumeInfo.fromJson(String str) => VolumeInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VolumeInfo.fromMap(Map<String, dynamic> json) => VolumeInfo(
    title: json["title"],
    authors: List<String>.from(json["authors"].map((x) => x)),
    publisher: json["publisher"],
    description: json["description"],
    readingModes: ReadingModes.fromMap(json["readingModes"]),
    pageCount: json["pageCount"],
    printType: json["printType"],
    categories: List<String>.from(json["categories"].map((x) => x)),
    imageLinks: ImageLinks.fromMap(json["imageLinks"]),
    language: json["language"],
    previewLink: json["previewLink"],
    infoLink: json["infoLink"],
    canonicalVolumeLink: json["canonicalVolumeLink"],
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "authors": List<dynamic>.from(authors.map((x) => x)),
    "publisher": publisher,
    "description": description,
    "readingModes": readingModes.toMap(),
    "pageCount": pageCount,
    "printType": printType,
    "categories": List<dynamic>.from(categories.map((x) => x)),
    "imageLinks": imageLinks.toMap(),
    "language": language,
    "previewLink": previewLink,
    "infoLink": infoLink,
    "canonicalVolumeLink": canonicalVolumeLink,
  };
}

class ImageLinks {
  final String smallThumbnail;
  final String thumbnail;

  ImageLinks({
    @required this.smallThumbnail,
    @required this.thumbnail,
  });

  factory ImageLinks.fromJson(String str) => ImageLinks.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ImageLinks.fromMap(Map<String, dynamic> json) => ImageLinks(
    smallThumbnail: json["smallThumbnail"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toMap() => {
    "smallThumbnail": smallThumbnail,
    "thumbnail": thumbnail,
  };
}

class ReadingModes {
  final bool text;
  final bool image;

  ReadingModes({
    @required this.text,
    @required this.image,
  });

  factory ReadingModes.fromJson(String str) => ReadingModes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReadingModes.fromMap(Map<String, dynamic> json) => ReadingModes(
    text: json["text"],
    image: json["image"],
  );

  Map<String, dynamic> toMap() => {
    "text": text,
    "image": image,
  };
}
