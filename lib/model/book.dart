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
  VolumeInfo volumeInfo;

  Item({
    this.id,
    this.volumeInfo,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"] == null ? null : json["id"],
    volumeInfo: json["volumeInfo"] == null ? null : VolumeInfo.fromJson(json["volumeInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "volumeInfo": volumeInfo == null ? null : volumeInfo.toJson(),
  };
}

class AccessInfo {
  Country country;

  AccessInfo({
    this.country,
  });

  factory AccessInfo.fromJson(Map<String, dynamic> json) =>
      AccessInfo(
        country: json["country"] == null ? null : countryValues.map[json["country"]],
      );

  Map<String, dynamic> toJson() =>
      {
        "country": country == null ? null : countryValues.reverse[country],
      };
}

enum AccessViewStatus { SAMPLE, NONE }

final accessViewStatusValues = EnumValues({
  "NONE": AccessViewStatus.NONE,
  "SAMPLE": AccessViewStatus.SAMPLE
});

enum Country { TR }

final countryValues = EnumValues({
  "TR": Country.TR
});

class Epub {
  bool isAvailable;
  String acsTokenLink;

  Epub({
    this.isAvailable,
    this.acsTokenLink,
  });

  factory Epub.fromJson(Map<String, dynamic> json) =>
      Epub(
        isAvailable: json["isAvailable"] == null ? null : json["isAvailable"],
        acsTokenLink: json["acsTokenLink"] == null ? null : json["acsTokenLink"],
      );

  Map<String, dynamic> toJson() =>
      {
        "isAvailable": isAvailable == null ? null : isAvailable,
        "acsTokenLink": acsTokenLink == null ? null : acsTokenLink,
      };
}

enum TextToSpeechPermission { ALLOWED, ALLOWED_FOR_ACCESSIBILITY }

final textToSpeechPermissionValues = EnumValues({
  "ALLOWED": TextToSpeechPermission.ALLOWED,
  "ALLOWED_FOR_ACCESSIBILITY": TextToSpeechPermission.ALLOWED_FOR_ACCESSIBILITY
});

enum Viewability { PARTIAL, NO_PAGES }

final viewabilityValues = EnumValues({
  "NO_PAGES": Viewability.NO_PAGES,
  "PARTIAL": Viewability.PARTIAL
});

enum Kind { BOOKS_VOLUME }

final kindValues = EnumValues({
  "books#volume": Kind.BOOKS_VOLUME
});

class SaleInfo {
  Country country;

  SaleInfo({
    this.country,
  });

  factory SaleInfo.fromJson(Map<String, dynamic> json) =>
      SaleInfo(
        country: json["country"] == null ? null : countryValues.map[json["country"]],
      );

  Map<String, dynamic> toJson() =>
      {
        "country": country == null ? null : countryValues.reverse[country],
      };
}



class VolumeInfo {
  String title;
  List<String> authors;
  String publisher;
  int pageCount;
  ImageLinks imageLinks;
  Language language;
  String subtitle;
  List<String> categories;

  VolumeInfo({
    this.title,
    this.authors,
    this.publisher,
    this.pageCount,
    this.imageLinks,
    this.language,
    this.subtitle,
    this.categories,
  });

  factory VolumeInfo.fromJson(Map<String, dynamic> json) => VolumeInfo(
    title: json["title"] == null ? null : json["title"],
    authors: json["authors"] == null ? null : List<String>.from(json["authors"].map((x) => x)),
    publisher: json["publisher"] == null ? null : json["publisher"],
    pageCount: json["pageCount"] == null ? null : json["pageCount"],
    imageLinks: json["imageLinks"] == null ? null : ImageLinks.fromJson(json["imageLinks"]),
    language: json["language"] == null ? null : languageValues.map[json["language"]],
    subtitle: json["subtitle"] == null ? null : json["subtitle"],
    categories: json["categories"] == null ? null : List<String>.from(json["categories"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "authors": authors == null ? null : List<dynamic>.from(authors.map((x) => x)),
    "publisher": publisher == null ? null : publisher,
    "pageCount": pageCount == null ? null : pageCount,
    "imageLinks": imageLinks == null ? null : imageLinks.toJson(),
    "language": language == null ? null : languageValues.reverse[language],
    "subtitle": subtitle == null ? null : subtitle,
    "categories": categories == null ? null : List<dynamic>.from(categories.map((x) => x)),
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


enum Language { TR, EN }

final languageValues = EnumValues({
  "en": Language.EN,
  "tr": Language.TR
});

enum MaturityRating { NOT_MATURE }

final maturityRatingValues = EnumValues({
  "NOT_MATURE": MaturityRating.NOT_MATURE
});


enum PrintType { BOOK }

final printTypeValues = EnumValues({
  "BOOK": PrintType.BOOK
});

class ReadingModes {
  bool text;
  bool image;

  ReadingModes({
    this.text,
    this.image,
  });

  factory ReadingModes.fromJson(Map<String, dynamic> json) =>
      ReadingModes(
        text: json["text"] == null ? null : json["text"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() =>
      {
        "text": text == null ? null : text,
        "image": image == null ? null : image,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
