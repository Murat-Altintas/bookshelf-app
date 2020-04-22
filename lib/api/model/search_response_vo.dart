import 'dart:convert';

class BookSearchResponseVo {
  String kind;
  int totalItems;
  List<BookItem> items;

  BookSearchResponseVo({
    this.kind,
    this.totalItems,
    this.items,
  });

  factory BookSearchResponseVo.fromRawJson(String str) => BookSearchResponseVo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BookSearchResponseVo.fromJson(Map<String, dynamic> json) => BookSearchResponseVo(
        kind: json['kind'],
        totalItems: json['totalItems'],
        items: json['items'] == null ? [] : List<BookItem>.from(json['items'].map((x) => BookItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'kind': kind,
        'totalItems': totalItems,
        'items': List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class BookItem {
  String kind;
  String id;
  String etag;
  String selfLink;
  VolumeInfo volumeInfo;

  BookItem({
    this.kind,
    this.id,
    this.etag,
    this.selfLink,
    this.volumeInfo,
  });

  @override
  String toString() {
    var str = 'BookItem {';
    if (kind != null) str += 'kind: $kind,';
    if (id != null) str += 'id: $id,';
    if (etag != null) str += 'etag: $etag,';
    if (selfLink != null) str += 'selfLink: $selfLink,';
    if (volumeInfo != null) str += 'volumeInfo: $volumeInfo';
    str += '}';
    return str;
  }

  factory BookItem.fromRawJson(String str) => BookItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BookItem.fromJson(Map<String, dynamic> json) => BookItem(
        kind: json['kind'],
        id: json['id'],
        etag: json['etag'],
        selfLink: json['selfLink'],
        volumeInfo: VolumeInfo.fromJson(json['volumeInfo']),
      );

  Map<String, dynamic> toJson() => {
        'kind': kind,
        'id': id,
        'etag': etag,
        'selfLink': selfLink,
        'volumeInfo': volumeInfo.toJson(),
      };
}

class VolumeInfo {
  String title;
  String subtitle;
  List<String> authors;
  String publisher;
  String publishedDate;
  List<IndustryIdentifier> industryIdentifiers;
  ReadingModes readingModes;
  int pageCount;
  String printType;
  double averageRating;
  int ratingsCount;
  String maturityRating;
  bool allowAnonLogging;
  String contentVersion;
  PanelizationSummary panelizationSummary;
  ImageLinks imageLinks;
  String language;
  String previewLink;
  String infoLink;
  String canonicalVolumeLink;
  String description;
  List<String> categories;
  bool comicsContent;

  VolumeInfo({
    this.title,
    this.subtitle,
    this.authors,
    this.publisher,
    this.publishedDate,
    this.industryIdentifiers,
    this.readingModes,
    this.pageCount,
    this.printType,
    this.averageRating,
    this.ratingsCount,
    this.maturityRating,
    this.allowAnonLogging,
    this.contentVersion,
    this.panelizationSummary,
    this.imageLinks,
    this.language,
    this.previewLink,
    this.infoLink,
    this.canonicalVolumeLink,
    this.description,
    this.categories,
    this.comicsContent,
  });

  factory VolumeInfo.fromRawJson(String str) => VolumeInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VolumeInfo.fromJson(Map<String, dynamic> json) => VolumeInfo(
        title: json['title'],
        subtitle: json['subtitle'],
        authors: json['authors'] == null ? [] : List<String>.from(json['authors'].map((x) => x)),
        publisher: json['publisher'],
        publishedDate: json['publishedDate'],
        industryIdentifiers: json['industryIdentifiers'] == null ? null : List<IndustryIdentifier>.from(json['industryIdentifiers'].map((x) => IndustryIdentifier.fromJson(x))),
        readingModes: json['readingModes'] == null ? null : ReadingModes.fromJson(json['readingModes']),
        pageCount: json['pageCount'],
        printType: json['printType'],
        averageRating: json['averageRating'],
        ratingsCount: json['ratingsCount'],
        maturityRating: json['maturityRating'],
        allowAnonLogging: json['allowAnonLogging'],
        contentVersion: json['contentVersion'],
        panelizationSummary: json['panelizationSummary'] == null ? null : PanelizationSummary.fromJson(json['panelizationSummary']),
        imageLinks: json['imageLinks'] == null ? null : ImageLinks.fromJson(json['imageLinks']),
        language: json['language'],
        previewLink: json['previewLink'],
        infoLink: json['infoLink'],
        canonicalVolumeLink: json['canonicalVolumeLink'],
        description: json['description'],
        categories: json['categories'] == null ? null : List<String>.from(json['categories'].map((x) => x)),
        comicsContent:
            // ignore: prefer_if_null_operators
            json['comicsContent'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
        'authors': List<dynamic>.from(authors.map((x) => x)),
        'publisher': publisher,
        'publishedDate': publishedDate,
        'industryIdentifiers': List<dynamic>.from(industryIdentifiers.map((x) => x.toJson())),
        'readingModes': readingModes.toJson(),
        'pageCount': pageCount,
        'printType': printType,
        'averageRating': averageRating,
        'ratingsCount': ratingsCount,
        'maturityRating': maturityRating,
        'allowAnonLogging': allowAnonLogging,
        'contentVersion': contentVersion,
        'panelizationSummary': panelizationSummary == null ? null : panelizationSummary.toJson(),
        'imageLinks': imageLinks == null ? null : imageLinks.toJson(),
        'language': language,
        'previewLink': previewLink,
        'infoLink': infoLink,
        'canonicalVolumeLink': canonicalVolumeLink,
        'description': description,
        'categories': categories == null ? null : List<dynamic>.from(categories.map((x) => x)),
        'comicsContent': comicsContent,
      };

  @override
  String toString() {
    var _fields = [];
    if (title != null) _fields.add('title: $title');
    if (subtitle != null) _fields.add('subtitle: $title');
    if (authors != null && authors.isNotEmpty) _fields.add('authors: ${authors.join(', ')}');
    if (publisher != null) _fields.add('publisher: ${publisher}');
    if (publishedDate != null) _fields.add('publishedDate: ${publishedDate}');
    if (industryIdentifiers != null) _fields.add('industryIdentifiers: ${industryIdentifiers}');
    if (readingModes != null) _fields.add('readingModes: ${readingModes}');
    if (pageCount != null) _fields.add('pageCount: ${pageCount}');
    if (printType != null) _fields.add('printType: ${printType}');
    if (averageRating != null) _fields.add('averageRating: ${averageRating}');
    if (ratingsCount != null) _fields.add('ratingsCount: ${averageRating}');
    if (maturityRating != null) _fields.add('maturityRating: ${maturityRating}');
    if (allowAnonLogging != null) _fields.add('allowAnonLogging: ${allowAnonLogging}');
    if (contentVersion != null) _fields.add('contentVersion: ${contentVersion}');
    if (panelizationSummary != null) _fields.add('panelizationSummary: ${panelizationSummary}');
    if (imageLinks != null) _fields.add('imageLinks: ${imageLinks}');
    if (language != null) _fields.add('language: ${language}');
    if (previewLink != null) _fields.add('previewLink: ${previewLink}');
    if (infoLink != null) _fields.add('infoLink: ${infoLink}');
    if (canonicalVolumeLink != null) _fields.add('canonicalVolumeLink: ${canonicalVolumeLink}');
    if (description != null) _fields.add('description: ${description}');
    if (categories != null && categories.isNotEmpty) _fields.add('categories: ${categories}');
    if (comicsContent != null && comicsContent) _fields.add('comicsContent: ${comicsContent}');
    return 'VolumeInfo { ${_fields.join(', ')}';
//   comicsContent: $comicsContent } ';
//    return 'VolumeInfo { title: $title, subtitle: $subtitle, authors: $authors, publisher: $publisher, publishedDate: $publishedDate, industryIdentifiers: $industryIdentifiers, readingModes: $readingModes, pageCount: $pageCount, printType: $printType, averageRating: $averageRating, ratingsCount: $ratingsCount, maturityRating: $maturityRating, allowAnonLogging: $allowAnonLogging, contentVersion: $contentVersion, panelizationSummary: ( $panelizationSummary ), imageLinks: ( $imageLinks ), language: $language, previewLink: $previewLink, infoLink: $infoLink, canonicalVolumeLink: $canonicalVolumeLink, description: $description, categories: $categories, comicsContent: $comicsContent } ';
  }
}

class ImageLinks {
  String smallThumbnail;
  String thumbnail;

  ImageLinks({
    this.smallThumbnail,
    this.thumbnail,
  });

  factory ImageLinks.fromRawJson(String str) => ImageLinks.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImageLinks.fromJson(Map<String, dynamic> json) => ImageLinks(
        smallThumbnail: json['smallThumbnail'],
        thumbnail: json['thumbnail'],
      );

  Map<String, dynamic> toJson() => {
        'smallThumbnail': smallThumbnail,
        'thumbnail': thumbnail,
      };

  @override
  String toString() {
    var _fields = [];
    if (smallThumbnail != null) _fields.add('smallThumbnail: $smallThumbnail');
    if (thumbnail != null) _fields.add('thumbnail: $thumbnail');
    return _fields.join(', ');
  }
}

class IndustryIdentifier {
  String type;
  String identifier;

  IndustryIdentifier({
    this.type,
    this.identifier,
  });

  factory IndustryIdentifier.fromRawJson(String str) => IndustryIdentifier.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IndustryIdentifier.fromJson(Map<String, dynamic> json) => IndustryIdentifier(
        type: json['type'],
        identifier: json['identifier'],
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'identifier': identifier,
      };

  @override
  String toString() {
    return '( type: $type, identifier: $identifier )';
  }
}

class PanelizationSummary {
  bool containsEpubBubbles;
  bool containsImageBubbles;

  PanelizationSummary({
    this.containsEpubBubbles,
    this.containsImageBubbles,
  });

  factory PanelizationSummary.fromRawJson(String str) => PanelizationSummary.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PanelizationSummary.fromJson(Map<String, dynamic> json) => PanelizationSummary(
        containsEpubBubbles: json['containsEpubBubbles'],
        containsImageBubbles: json['containsImageBubbles'],
      );

  Map<String, dynamic> toJson() => {
        'containsEpubBubbles': containsEpubBubbles,
        'containsImageBubbles': containsImageBubbles,
      };

  @override
  String toString() {
    return 'containsEpub: $containsEpubBubbles, containsImage: $containsImageBubbles';
  }
}

class ReadingModes {
  bool text;
  bool image;

  ReadingModes({
    this.text,
    this.image,
  });

  factory ReadingModes.fromRawJson(String str) => ReadingModes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReadingModes.fromJson(Map<String, dynamic> json) => ReadingModes(
        text: json['text'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'image': image,
      };

  @override
  String toString() {
    return [
      if (text) 'text',
      if (image) 'image',
    ].join(', ');
  }
}
