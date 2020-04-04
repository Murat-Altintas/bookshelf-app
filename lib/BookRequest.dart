import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:grade_point_avarage/MasterPage.dart';
import 'model/book.dart';
import 'style.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookRequest extends StatefulWidget {
  @override
  _BookRequestState createState() => _BookRequestState();
}

class _BookRequestState extends State<BookRequest> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Book allBook;

  var bookName = TextEditingController();

  getData(String bookName) async {
    var dio = Dio();
    var response = await dio
        .get("https://www.googleapis.com/books/v1/volumes?q=$bookName");

    Map data = await response.data;
    allBook = Book.fromJson(data);
    setState(() {});
  }

  //------------------------------------------------------------//
  double heightSize(double value) {
    value /= 100;
    return MediaQuery.of(context).size.height * value;
  }

  double widthSize(double value) {
    value /= 100;
    return MediaQuery.of(context).size.width * value;
  }

  //------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    newSearch() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: heightSize(5),
              color: Colors.red,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MasterPage()));
              },
            ),
            Container(
              width: widthSize(65),
              child: TextField(
                expands: false,
                controller: bookName,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20, top: 3),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(60.0)),
                    borderSide: BorderSide(color: Colors.red, width: 1),
                  ),
                  hintText: "Search your favorite book...",
                  hintStyle: search,
                ),
                onSubmitted: (s) async {
                  //return allBook.items;
                  // print(allBook[0].items);
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              iconSize: heightSize(5),
              color: Colors.red,
              onPressed: () async {
                getData(bookName.text);
                //_emailveSifreLogin();
              },
            ),
          ],
        );
    return newSearch();
  }
}
