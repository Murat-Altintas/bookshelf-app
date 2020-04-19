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
  Kind kind;
  String id;
  String etag;
  String selfLink;
  VolumeInfo volumeInfo;
  SaleInfo saleInfo;
  AccessInfo accessInfo;
  SearchInfo searchInfo;

  Item({
    this.kind,
    this.id,
    this.etag,
    this.selfLink,
    this.volumeInfo,
    this.saleInfo,
    this.accessInfo,
    this.searchInfo,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    kind: json["kind"] == null ? null : kindValues.map[json["kind"]],
    id: json["id"] == null ? null : json["id"],
    etag: json["etag"] == null ? null : json["etag"],
    selfLink: json["selfLink"] == null ? null : json["selfLink"],
    volumeInfo: json["volumeInfo"] == null ? null : VolumeInfo.fromJson(json["volumeInfo"]),
    saleInfo: json["saleInfo"] == null ? null : SaleInfo.fromJson(json["saleInfo"]),
    accessInfo: json["accessInfo"] == null ? null : AccessInfo.fromJson(json["accessInfo"]),
    searchInfo: json["searchInfo"] == null ? null : SearchInfo.fromJson(json["searchInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "kind": kind == null ? null : kindValues.reverse[kind],
    "id": id == null ? null : id,
    "etag": etag == null ? null : etag,
    "selfLink": selfLink == null ? null : selfLink,
    "volumeInfo": volumeInfo == null ? null : volumeInfo.toJson(),
    "saleInfo": saleInfo == null ? null : saleInfo.toJson(),
    "accessInfo": accessInfo == null ? null : accessInfo.toJson(),
    "searchInfo": searchInfo == null ? null : searchInfo.toJson(),
  };
}

class AccessInfo {
  Country country;
  Viewability viewability;
  bool embeddable;
  bool publicDomain;
  TextToSpeechPermission textToSpeechPermission;
  Epub epub;
  Epub pdf;
  String webReaderLink;
  AccessViewStatus accessViewStatus;
  bool quoteSharingAllowed;

  AccessInfo({
    this.country,
    this.viewability,
    this.embeddable,
    this.publicDomain,
    this.textToSpeechPermission,
    this.epub,
    this.pdf,
    this.webReaderLink,
    this.accessViewStatus,
    this.quoteSharingAllowed,
  });

  factory AccessInfo.fromJson(Map<String, dynamic> json) =>
      AccessInfo(
        country: json["country"] == null ? null : countryValues.map[json["country"]],
        viewability: json["viewability"] == null ? null : viewabilityValues.map[json["viewability"]],
        embeddable: json["embeddable"] == null ? null : json["embeddable"],
        publicDomain: json["publicDomain"] == null ? null : json["publicDomain"],
        textToSpeechPermission: json["textToSpeechPermission"] == null ? null : textToSpeechPermissionValues.map[json["textToSpeechPermission"]],
        epub: json["epub"] == null ? null : Epub.fromJson(json["epub"]),
        pdf: json["pdf"] == null ? null : Epub.fromJson(json["pdf"]),
        webReaderLink: json["webReaderLink"] == null ? null : json["webReaderLink"],
        accessViewStatus: json["accessViewStatus"] == null ? null : accessViewStatusValues.map[json["accessViewStatus"]],
        quoteSharingAllowed: json["quoteSharingAllowed"] == null ? null : json["quoteSharingAllowed"],
      );

  Map<String, dynamic> toJson() =>
      {
        "country": country == null ? null : countryValues.reverse[country],
        "viewability": viewability == null ? null : viewabilityValues.reverse[viewability],
        "embeddable": embeddable == null ? null : embeddable,
        "publicDomain": publicDomain == null ? null : publicDomain,
        "textToSpeechPermission": textToSpeechPermission == null ? null : textToSpeechPermissionValues.reverse[textToSpeechPermission],
        "epub": epub == null ? null : epub.toJson(),
        "pdf": pdf == null ? null : pdf.toJson(),
        "webReaderLink": webReaderLink == null ? null : webReaderLink,
        "accessViewStatus": accessViewStatus == null ? null : accessViewStatusValues.reverse[accessViewStatus],
        "quoteSharingAllowed": quoteSharingAllowed == null ? null : quoteSharingAllowed,
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
  Saleability saleability;
  bool isEbook;
  SaleInfoListPrice listPrice;
  SaleInfoListPrice retailPrice;
  String buyLink;
  List<Offer> offers;

  SaleInfo({
    this.country,
    this.saleability,
    this.isEbook,
    this.listPrice,
    this.retailPrice,
    this.buyLink,
    this.offers,
  });

  factory SaleInfo.fromJson(Map<String, dynamic> json) =>
      SaleInfo(
        country: json["country"] == null ? null : countryValues.map[json["country"]],
        saleability: json["saleability"] == null ? null : saleabilityValues.map[json["saleability"]],
        isEbook: json["isEbook"] == null ? null : json["isEbook"],
        listPrice: json["listPrice"] == null ? null : SaleInfoListPrice.fromJson(json["listPrice"]),
        retailPrice: json["retailPrice"] == null ? null : SaleInfoListPrice.fromJson(json["retailPrice"]),
        buyLink: json["buyLink"] == null ? null : json["buyLink"],
        offers: json["offers"] == null ? null : List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "country": country == null ? null : countryValues.reverse[country],
        "saleability": saleability == null ? null : saleabilityValues.reverse[saleability],
        "isEbook": isEbook == null ? null : isEbook,
        "listPrice": listPrice == null ? null : listPrice.toJson(),
        "retailPrice": retailPrice == null ? null : retailPrice.toJson(),
        "buyLink": buyLink == null ? null : buyLink,
        "offers": offers == null ? null : List<dynamic>.from(offers.map((x) => x.toJson())),
      };
}

class SaleInfoListPrice {
  double amount;
  String currencyCode;

  SaleInfoListPrice({
    this.amount,
    this.currencyCode,
  });

  factory SaleInfoListPrice.fromJson(Map<String, dynamic> json) =>
      SaleInfoListPrice(
        amount: json["amount"] == null ? null : json["amount"].toDouble(),
        currencyCode: json["currencyCode"] == null ? null : json["currencyCode"],
      );

  Map<String, dynamic> toJson() =>
      {
        "amount": amount == null ? null : amount,
        "currencyCode": currencyCode == null ? null : currencyCode,
      };
}

class Offer {
  int finskyOfferType;
  OfferListPrice listPrice;
  OfferListPrice retailPrice;

  Offer({
    this.finskyOfferType,
    this.listPrice,
    this.retailPrice,
  });

  factory Offer.fromJson(Map<String, dynamic> json) =>
      Offer(
        finskyOfferType: json["finskyOfferType"] == null ? null : json["finskyOfferType"],
        listPrice: json["listPrice"] == null ? null : OfferListPrice.fromJson(json["listPrice"]),
        retailPrice: json["retailPrice"] == null ? null : OfferListPrice.fromJson(json["retailPrice"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "finskyOfferType": finskyOfferType == null ? null : finskyOfferType,
        "listPrice": listPrice == null ? null : listPrice.toJson(),
        "retailPrice": retailPrice == null ? null : retailPrice.toJson(),
      };
}

class OfferListPrice {
  double amountInMicros;
  String currencyCode;

  OfferListPrice({
    this.amountInMicros,
    this.currencyCode,
  });

  factory OfferListPrice.fromJson(Map<String, dynamic> json) =>
      OfferListPrice(
        amountInMicros: json["amountInMicros"] == null ? null : json["amountInMicros"],
        currencyCode: json["currencyCode"] == null ? null : json["currencyCode"],
      );

  Map<String, dynamic> toJson() =>
      {
        "amountInMicros": amountInMicros == null ? null : amountInMicros,
        "currencyCode": currencyCode == null ? null : currencyCode,
      };
}

enum Saleability { FOR_SALE, NOT_FOR_SALE }

final saleabilityValues = EnumValues({
  "FOR_SALE": Saleability.FOR_SALE,
  "NOT_FOR_SALE": Saleability.NOT_FOR_SALE
});

class SearchInfo {
  String textSnippet;

  SearchInfo({
    this.textSnippet,
  });

  factory SearchInfo.fromJson(Map<String, dynamic> json) =>
      SearchInfo(
        textSnippet: json["textSnippet"] == null ? null : json["textSnippet"],
      );

  Map<String, dynamic> toJson() =>
      {
        "textSnippet": textSnippet == null ? null : textSnippet,
      };
}

class VolumeInfo {
  String title;
  List<String> authors;
  String publisher;
  String publishedDate;
  List<IndustryIdentifier> industryIdentifiers;
  ReadingModes readingModes;
  int pageCount;
  PrintType printType;
  MaturityRating maturityRating;
  bool allowAnonLogging;
  String contentVersion;
  PanelizationSummary panelizationSummary;
  ImageLinks imageLinks;
  Language language;
  String previewLink;
  String infoLink;
  String canonicalVolumeLink;
  String subtitle;
  String description;
  List<String> categories;
  double averageRating;
  int ratingsCount;

  VolumeInfo({
    this.title,
    this.authors,
    this.publisher,
    this.publishedDate,
    this.industryIdentifiers,
    this.readingModes,
    this.pageCount,
    this.printType,
    this.maturityRating,
    this.allowAnonLogging,
    this.contentVersion,
    this.panelizationSummary,
    this.imageLinks,
    this.language,
    this.previewLink,
    this.infoLink,
    this.canonicalVolumeLink,
    this.subtitle,
    this.description,
    this.categories,
    this.averageRating,
    this.ratingsCount,
  });

  factory VolumeInfo.fromJson(Map<String, dynamic> json) => VolumeInfo(
    title: json["title"] == null ? null : json["title"],
    authors: json["authors"] == null ? null : List<String>.from(json["authors"].map((x) => x)),
    publisher: json["publisher"] == null ? null : json["publisher"],
    publishedDate: json["publishedDate"] == null ? null : json["publishedDate"],
    industryIdentifiers: json["industryIdentifiers"] == null ? null : List<IndustryIdentifier>.from(json["industryIdentifiers"].map((x) => IndustryIdentifier.fromJson(x))),
    readingModes: json["readingModes"] == null ? null : ReadingModes.fromJson(json["readingModes"]),
    pageCount: json["pageCount"] == null ? null : json["pageCount"],
    printType: json["printType"] == null ? null : printTypeValues.map[json["printType"]],
    maturityRating: json["maturityRating"] == null ? null : maturityRatingValues.map[json["maturityRating"]],
    allowAnonLogging: json["allowAnonLogging"] == null ? null : json["allowAnonLogging"],
    contentVersion: json["contentVersion"] == null ? null : json["contentVersion"],
    panelizationSummary: json["panelizationSummary"] == null ? null : PanelizationSummary.fromJson(json["panelizationSummary"]),
    imageLinks: json["imageLinks"] == null ? null : ImageLinks.fromJson(json["imageLinks"]),
    language: json["language"] == null ? null : languageValues.map[json["language"]],
    previewLink: json["previewLink"] == null ? null : json["previewLink"],
    infoLink: json["infoLink"] == null ? null : json["infoLink"],
    canonicalVolumeLink: json["canonicalVolumeLink"] == null ? null : json["canonicalVolumeLink"],
    subtitle: json["subtitle"] == null ? null : json["subtitle"],
    description: json["description"] == null ? null : json["description"],
    categories: json["categories"] == null ? null : List<String>.from(json["categories"].map((x) => x)),
    averageRating: json["averageRating"] == null ? null : json["averageRating"],
    ratingsCount: json["ratingsCount"] == null ? null : json["ratingsCount"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "authors": authors == null ? null : List<dynamic>.from(authors.map((x) => x)),
    "publisher": publisher == null ? null : publisher,
    "publishedDate": publishedDate == null ? null : publishedDate,
    "industryIdentifiers": industryIdentifiers == null ? null : List<dynamic>.from(industryIdentifiers.map((x) => x.toJson())),
    "readingModes": readingModes == null ? null : readingModes.toJson(),
    "pageCount": pageCount == null ? null : pageCount,
    "printType": printType == null ? null : printTypeValues.reverse[printType],
    "maturityRating": maturityRating == null ? null : maturityRatingValues.reverse[maturityRating],
    "allowAnonLogging": allowAnonLogging == null ? null : allowAnonLogging,
    "contentVersion": contentVersion == null ? null : contentVersion,
    "panelizationSummary": panelizationSummary == null ? null : panelizationSummary.toJson(),
    "imageLinks": imageLinks == null ? null : imageLinks.toJson(),
    "language": language == null ? null : languageValues.reverse[language],
    "previewLink": previewLink == null ? null : previewLink,
    "infoLink": infoLink == null ? null : infoLink,
    "canonicalVolumeLink": canonicalVolumeLink == null ? null : canonicalVolumeLink,
    "subtitle": subtitle == null ? null : subtitle,
    "description": description == null ? null : description,
    "categories": categories == null ? null : List<dynamic>.from(categories.map((x) => x)),
    "averageRating": averageRating == null ? null : averageRating,
    "ratingsCount": ratingsCount == null ? null : ratingsCount,
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

class IndustryIdentifier {
  Type type;
  String identifier;

  IndustryIdentifier({
    this.type,
    this.identifier,
  });

  factory IndustryIdentifier.fromJson(Map<String, dynamic> json) =>
      IndustryIdentifier(
        type: json["type"] == null ? null : typeValues.map[json["type"]],
        identifier: json["identifier"] == null ? null : json["identifier"],
      );

  Map<String, dynamic> toJson() =>
      {
        "type": type == null ? null : typeValues.reverse[type],
        "identifier": identifier == null ? null : identifier,
      };
}

enum Type { ISBN_13, ISBN_10, OTHER }

final typeValues = EnumValues({
  "ISBN_10": Type.ISBN_10,
  "ISBN_13": Type.ISBN_13,
  "OTHER": Type.OTHER
});

enum Language { TR, EN }

final languageValues = EnumValues({
  "en": Language.EN,
  "tr": Language.TR
});

enum MaturityRating { NOT_MATURE }

final maturityRatingValues = EnumValues({
  "NOT_MATURE": MaturityRating.NOT_MATURE
});

class PanelizationSummary {
  bool containsEpubBubbles;
  bool containsImageBubbles;

  PanelizationSummary({
    this.containsEpubBubbles,
    this.containsImageBubbles,
  });

  factory PanelizationSummary.fromJson(Map<String, dynamic> json) =>
      PanelizationSummary(
        containsEpubBubbles: json["containsEpubBubbles"] == null ? null : json["containsEpubBubbles"],
        containsImageBubbles: json["containsImageBubbles"] == null ? null : json["containsImageBubbles"],
      );

  Map<String, dynamic> toJson() =>
      {
        "containsEpubBubbles": containsEpubBubbles == null ? null : containsEpubBubbles,
        "containsImageBubbles": containsImageBubbles == null ? null : containsImageBubbles,
      };
}

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
