import 'search_response_vo.dart';

class BookResult {
  final String title;
  final List<String> authors;
  final String photoUrl;
  final String description;

  BookResult({this.title, this.authors, this.photoUrl, this.description});
//      SearchResponseVo.fromJson(json.decode(str));
}
