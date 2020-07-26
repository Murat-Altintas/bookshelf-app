import 'dart:async';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grade_point_avarage/MasterPage.dart';
import 'init/theme/BlueTheme.dart';
import 'model/book.dart';
import 'package:grade_point_avarage/View/ContextExtension.dart';

class ResaultPage extends StatefulWidget {
  @override
  _ResaultPageState createState() => _ResaultPageState();
}

class _ResaultPageState extends State<ResaultPage> {
  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ScrollController _scrollController = ScrollController();
  Book allBook;
  int startIndex = 0;
  var bookName = TextEditingController();

  getData(String bookName) async {
    var dio = Dio();
    var response = await dio.get(
        "https://www.googleapis.com/books/v1/volumes?q=$bookName+&langRestrict=tr&maxResults=10&startIndex=$startIndex");
    Book tempBook;
    Map data = await response.data;
    if (allBook == null)
      allBook = Book.fromJson(data);
    else {
      tempBook = Book.fromJson(data);
      allBook.items += tempBook.items;
    }

    print(allBook.items.length);
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        startIndex += 10;
        getData(bookName.text);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            resaultPng(),
            searchBar(),
            SizedBox(
              height: heightSize(2),
            ),
            if (allBook != null)
              Expanded(
                  child: Column(
                children: <Widget>[
                  CarouselSlider.builder(
                    itemCount: allBook.items.length,
                    options: CarouselOptions(
                        enlargeCenterPage: true,
                        viewportFraction: 0.6,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 4),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        height: heightSize(55)),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          width: widthSize(60),
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            /*
                            border: Border.all(
                              color: Colors.black12,
                              width: 2,
                            ),
                             */
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                child: allBook.items[index].volumeInfo.imageLinks != null
                                    ? Image.network(
                                        allBook.items[index].volumeInfo.imageLinks.thumbnail,
                                        height: heightSize(35),
                                        fit: BoxFit.fill,
                                      )
                                    : Text("no image"),
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    allBook.items[index].volumeInfo.title == null
                                        ? "No data"
                                        : allBook.items[index].volumeInfo.title,
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  Text(
                                    allBook.items[index].volumeInfo.authors.toString() == null
                                        ? "No data"
                                        : allBook.items[index].volumeInfo.authors.toString(),
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              )
                            ],
                          ));
                    },
                  )
                ],
              )),
          ],
        ),
      ),
    );
  }

  Widget titleText() => RichText(
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
                height: heightSize(0.20),
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
                hintStyle: blueTheme.textTheme.headline2
                    .copyWith(fontSize: context.normalText),
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

  resaultPng() => Container(
        height: heightSize(28),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: heightSize(6),
              left: widthSize(5),
              child: titleText(),
            ),
            Positioned(
              left: widthSize(46),
              top: heightSize(2),
              child: Container(
                  height: heightSize(25), child: Image.asset("assets/images/resaultPage.png")),
            ),
          ],
        ),
      );

  Future<void> _saveBookTitle(selectedBook) async {
    Map<String, String> idMap = Map();
    idMap[selectedBook.id] = selectedBook.id;
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;

    String title = selectedBook.volumeInfo.title == null
        ? "NO DATA"
        : selectedBook.volumeInfo.title.toString();
    String authors = selectedBook.volumeInfo.authors == null
        ? "NO DATA"
        : selectedBook.volumeInfo.authors.first.toString();
    String publisher = selectedBook.volumeInfo.publisher == null
        ? "NO DATA"
        : selectedBook.volumeInfo.publisher.toString();
    String image = selectedBook.volumeInfo.imageLinks == null
        ? "NO DATA"
        : selectedBook.volumeInfo.imageLinks.thumbnail.toString();

    Map<String, String> mixMap = {
      "title": title,
      "authors": authors,
      "publisher": publisher,
      "image": image,
    };

    await _firestore.collection(uid).document("$idMap").setData(mixMap, merge: true);

    /*
    Map<String, String> authorMap = Map();
    Map<String, String> publisherMap = Map();
    Map<String, String> imgMap = Map();

    authorMap[selectedBook.id] = selectedBook.volumeInfo.authors.first.toString();
    _firestore.document("bookrequest/authorList").setData(authorMap, merge: true);

    publisherMap[selectedBook.id] = selectedBook.volumeInfo.publisher.toString();
    _firestore.document("bookrequest/publisherList").setData(publisherMap, merge: true);

    imgMap[selectedBook.id] = selectedBook.volumeInfo.imageLinks.thumbnail.toString();
    _firestore.document("bookrequest/imgList").setData(imgMap, merge: true);
    
     */
  }
}
