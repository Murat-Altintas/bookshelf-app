import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grade_point_avarage/MasterPage.dart';
import 'model/book.dart';
import 'style.dart';
import 'dart:developer' as dev;

class ResaultPage extends StatefulWidget {
  @override
  _ResaultPageState createState() => _ResaultPageState();
}

class _ResaultPageState extends State<ResaultPage> {
  final Firestore _firestore = Firestore.instance;

  Book allBook;

  var bookName = TextEditingController();

  getData(String bookName) async {
    var dio = Dio();
    var response = await dio.get("https://www.googleapis.com/books/v1/volumes?q=$bookName");

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
    var titleText = RichText(
      text: TextSpan(
        text: "What ",
        style: TextStyle(
          fontSize: heightSize(5),
          color: Colors.lightBlue,
          fontFamily: 'MainFont',
          fontWeight: FontWeight.w700,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'would \n',
            style: TextStyle(
              fontSize: heightSize(5),
              color: Colors.lightBlue,
              fontFamily: 'MainFont',
              fontWeight: FontWeight.w300,
            ),
          ),
          TextSpan(
            text: 'you like to \n',
            style: TextStyle(
              fontSize: heightSize(5),
              color: Colors.lightBlue,
              fontFamily: 'MainFont',
              fontWeight: FontWeight.w300,
            ),
          ),
          TextSpan(
            text: 'learn today?',
            style: TextStyle(
              height: heightSize(0.15),
              fontSize: heightSize(5),
              color: Colors.lightBlue,
              fontFamily: 'MainFont',
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
    searchBar() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: heightSize(5),
              color: Colors.purple,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MasterPage()));
              },
            ),
            Container(
              width: widthSize(70),
              child: TextField(
                expands: false,
                controller: bookName,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20, top: 3),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(60.0)),
                    borderSide: BorderSide(color: Colors.lightBlue, width: 1),
                  ),
                  hintText: "Search your favorite book...",
                  hintStyle: search,
                ),
                onSubmitted: (s) async {
                  getData(bookName.text);
                  // print(allBook[0].items);
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              iconSize: heightSize(5),
              color: Colors.purple,
              onPressed: () async {
                getData(bookName.text);
              },
            ),
          ],
        );
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: heightSize(28),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: heightSize(6),
                    left: widthSize(5),
                    child: titleText,
                  ),
                  Positioned(
                    left: widthSize(46),
                    top: heightSize(2),
                    child: Container(height: heightSize(25), child: Image.asset("assets/images/resaultPage.png")),
                  ),
                ],
              ),
            ),
            searchBar(),
            SizedBox(
              height: heightSize(2),
            ),
            LimitedBox(
              maxHeight: heightSize(60),
              child: ListView(
                children: <Widget>[
                  if (allBook != null)
                    for (int i = 0; i < allBook.items.length; i++)
                      GestureDetector(
                        //onTap: () => _saveSelectedBook(allBook.items[i]),
                        child: Column(
                          children: <Widget>[
                            allBook.items.length == 0
                                ? 'NO DATA'
                                : Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.only(left: widthSize(5), right: widthSize(5)),
                              height: heightSize(25),
                              width: widthSize(90),
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      //height: heightSize(30),
                                      child: allBook.items[i].volumeInfo.imageLinks == null
                                          ? Text("NO IMAGE :(",
                                          style: TextStyle(
                                            color: Colors.red,
                                          ))
                                          : Image.network("${allBook.items[i].volumeInfo.imageLinks.thumbnail}"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: widthSize(3),
                                  ),
                                  Expanded(
                                    flex: 9,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text("${allBook.items[i].volumeInfo.title == null ? "NO DATA" : allBook.items[i].volumeInfo.title.toUpperCase()}",
                                            //overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: heightSize(2),
                                              color: Colors.lightBlue,
                                              fontFamily: 'MainFont',
                                              fontWeight: FontWeight.w700,
                                            )),
                                        Text(
                                          "${allBook.items[i].volumeInfo.authors == null ? "NO DATA" : allBook.items[i].volumeInfo.authors.first}",
                                          style: TextStyle(
                                            fontSize: heightSize(2),
                                            color: Colors.purple,
                                          ),
                                        ),
                                        SizedBox(
                                          height: heightSize(2),
                                        ),
                                        Text(
                                          "${allBook.items[i].volumeInfo.publisher == null ? "NO DATA" : allBook.items[i].volumeInfo.publisher}",
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.favorite_border),
                                    iconSize: heightSize(4),
                                    color: Colors.purple,
                                    onPressed: () async {
                                      _saveFavoriteBook(allBook.items[i]);
                                    },
                                  ),
                                ],
                              ),
                                  ),
                            SizedBox(
                              height: heightSize(3),
                            ),
                          ],
                        ),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveFavoriteBook(selectedBook) {
    Map<String, String> favoriteMap = Map();

    favoriteMap[selectedBook.id] = selectedBook.volumeInfo.title;

    _firestore.collection("bookrequests").document("favorites").setData(favoriteMap, merge: true);
  }

  void _saveAcquisitionsBook(selectedBook) {
    Map<String, String> acquisitionsMap = Map();

    acquisitionsMap[selectedBook.id] = selectedBook.volumeInfo.title;

    _firestore.collection("bookrequests").document("acquisitions").setData(acquisitionsMap, merge: true);
  }
}
