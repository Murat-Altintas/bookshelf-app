import 'dart:convert';

import 'package:http/http.dart';

import 'model/search_response_vo.dart';

var api = GBooksApi();

class GBooksApi {
  //  static String _domain =
//      'www.googleapis.com'; //volumes?q=turkish+subject:ottoman

  static String baseUrl = 'https://www.googleapis.com/books/v1/';
  String apiKey; // none
  Client client = Client();

  GBooksApi() {
    // init vars.
  }

  // check
  // https://developers.google.com/books/docs/v1/using#PerformingSearch
  Future<BookSearchResponseVo> search(
    String query, {
    String intitle = '',
    String inauthor = '',
    String inpublisher = '',
    String subject = '',
    String isbn = '',
    String lccn = '',
    String oclc = '',
    String lang = '',
    bool prettyPrint = false,
    SearchQueryFilter filter,
    int startIndex = 0,
    int maxResults = 10,
    SearchQueryOrderBy orderBy,
    SearchQueryPrintType printType,
    SearchQueryProjection projection,
    String apiKey,
    String accessToken,
    String fields,
  }) async {
    var filtersOptions = {
      'intitle': intitle,
      'inauthor': inauthor,
      'inpublisher': inpublisher,
      'subject': subject,
      'isbn': isbn,
      'lccn': lccn,
      'oclc': oclc,
    };
    filtersOptions.forEach((key, value) {
      if (value != null && value.isNotEmpty) {
        query += '+$key:$value';
      }
    });
    var url = baseUrl + 'volumes?q=$query';
    if (lang != null && lang.isNotEmpty) {
      url += '&langRestrict=$lang';
    }

    if (accessToken != null && accessToken.isNotEmpty) {
      url += '&access_token=$accessToken';
    } else if (apiKey != null && apiKey.isNotEmpty) {
      url += '&key=$apiKey';
    }

    // partial responses
    if (fields != null && fields.isNotEmpty) {
      //    kind,items(title,characteristics/length)
      url += '&fields=$fields';
    }

    prettyPrint ??= false;
    url += '&prettyPrint=$prettyPrint';

    startIndex ??= 0;
    maxResults ??= 10;

    url += '&maxResults=$maxResults';
    url += '&startIndex=$startIndex';

    if (filter != null) {
      url += '&filter=${filter.value}';
    }

    if (orderBy != null) {
      url += '&orderBy=${orderBy.value}';
    }

    if (printType != null) {
      url += '&printType=${printType.value}';
    }

    if (projection != null) {
      url += '&projection=${projection.value}';
    }

//    url += '&projection=${projection.value}';

    if (apiKey != null) {
      url += '&key=$apiKey';
    }

    print(url);
    var resp = await client.get(url);
    var responseString = utf8.decode(resp.bodyBytes);
    return BookSearchResponseVo.fromRawJson(responseString);
//    return SearchResponseVo.fromRawJson(responseString);
  }
}

class SearchQueryProjection {
  static const SearchQueryProjection full = SearchQueryProjection('full');
  static const SearchQueryProjection lite = SearchQueryProjection('lite');
  final String value;

  const SearchQueryProjection(this.value);
}

class SearchQueryPrintType {
  static const SearchQueryPrintType all = SearchQueryPrintType('all');
  static const SearchQueryPrintType books = SearchQueryPrintType('books');
  static const SearchQueryPrintType magazines = SearchQueryPrintType('magazines');
  final String value;

  const SearchQueryPrintType(this.value);
}

class SearchQueryOrderBy {
  static const SearchQueryOrderBy relevance = SearchQueryOrderBy('relevance');
  static const SearchQueryOrderBy newest = SearchQueryOrderBy('newest');
  final String value;

  const SearchQueryOrderBy(this.value);
}

class SearchQueryFilter {
  static const SearchQueryFilter partial = SearchQueryFilter('partial');
  static const SearchQueryFilter full = SearchQueryFilter('full');
  static const SearchQueryFilter freeEbooks = SearchQueryFilter('free-ebooks');
  static const SearchQueryFilter paidEbooks = SearchQueryFilter('paid-ebooks');
  static const SearchQueryFilter ebooks = SearchQueryFilter('ebooks');

  final String value;

  const SearchQueryFilter(this.value);
}
