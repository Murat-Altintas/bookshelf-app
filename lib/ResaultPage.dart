import 'dart:async';
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
  Book tempBook;
  int startIndex = 0;
  var bookName = TextEditingController();

  getData(String bookName) async {
    var dio = Dio();
    var response = await dio.get(
        "https://www.googleapis.com/books/v1/volumes?q=$bookName+&langRestrict=tr&maxResults=10&startIndex=$startIndex");
    Map data = await response.data;
    if (allBook == null)
      allBook = Book.fromJson(data);
    else {
      //tempBook'u neden kullanıyoruz?
      tempBook = Book.fromJson(data);
      allBook.items += tempBook.items;
    }
    print(allBook.items.length);
    setState(() {});
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
              height: context.lowestContainer,
            ),
            if (allBook != null)
              Expanded(
                  child: Column(
                children: <Widget>[
                  CarouselSlider.builder(
                    itemCount: allBook.items.length,
                    options: CarouselOptions(
                        pauseAutoPlayOnTouch: true,
                        disableCenter: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.scale,
                        enlargeCenterPage: true,
                        viewportFraction: 0.6,
                        enableInfiniteScroll: true,
                        autoPlay: false,
                        autoPlayInterval: Duration(seconds: 4),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.decelerate,
                        height: context.height * 57),
                    itemBuilder: (BuildContext context, int index) {
                      var pressAttention = false;
                      return Container(
                          width: context.height * 55,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                offset: Offset(10, 0),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                child: allBook.items[index].volumeInfo.imageLinks != null
                                    ? Image.network(
                                        allBook.items[index].volumeInfo.imageLinks.thumbnail,
                                        height: context.height * 35,
                                        fit: BoxFit.fill,
                                      )
                                    : Text("no image"),
                              ),
                              Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: context.lowestContainer,
                                  ),
                                  Text(
                                    allBook.items[index].volumeInfo.title == null
                                        ? "No data"
                                        : allBook.items[index].volumeInfo.title.toUpperCase(),
                                    style: blueTheme.primaryTextTheme.headline1
                                        .copyWith(fontSize: context.lowText),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    allBook.items[index].volumeInfo.authors.toString() == null
                                        ? "No data"
                                        : allBook.items[index].volumeInfo.authors
                                            .toString()
                                            .replaceAll("]", "")
                                            .replaceAll("[", ""),
                                    style: blueTheme.primaryTextTheme.headline2
                                        .copyWith(fontSize: context.lowText),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    allBook.items[index].volumeInfo.publisher.toString() == null
                                        ? "No data"
                                        : allBook.items[index].volumeInfo.publisher.toString(),
                                    style: blueTheme.primaryTextTheme.headline3
                                        .copyWith(fontSize: context.lowText),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: context.height * 1,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.favorite_border),
                                        color: pressAttention ? Colors.red : Colors.blue,
                                        onPressed: () =>
                                            setState(() => pressAttention = !pressAttention),
                                        highlightColor: Colors.black,
                                        splashColor: Colors.red,
                                        focusColor: Colors.green,
                                        hoverColor: Colors.yellow,
                                        iconSize: 30,
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.check_box_outline_blank),
                                        onPressed: () {},
                                        highlightColor: Colors.blue,
                                        iconSize: 30,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
          text: "What would \n",
          style: blueTheme.textTheme.headline5.copyWith(fontSize: context.height * 4.5),
          children: <TextSpan>[
            TextSpan(
                text: 'you like to \n',
                style: blueTheme.textTheme.headline5
                    .copyWith(fontSize: context.height * 4.5, height: context.height * 0.2)),
            TextSpan(
                text: 'learn today?',
                style: blueTheme.textTheme.headline5
                    .copyWith(fontSize: context.height * 4.5, height: context.height * 0.2)),
          ],
        ),
      );

  searchBar() => Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: context.iconSize,
            color: blueTheme.primaryIconTheme.color,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MasterPage()));
            },
          ),
          Container(
            width: context.width * 70,
            child: TextField(
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
                hintStyle: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
              ),
              onSubmitted: (s) async {
                getData(bookName.text);
                // print(allBook[0].items);
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            iconSize: context.height * 5,
            color: Colors.purple,
            onPressed: () async {
              getData(bookName.text);
            },
          ),
        ],
      );

  resaultPng() => Container(
        height: context.height * 28,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: context.height * 6,
              left: context.height * 2,
              child: titleText(),
            ),
            Positioned(
              left: context.width * 46,
              top: context.height * 2,
              child: Container(
                  height: context.height * 25, child: Image.asset("assets/images/resaultPage.png")),
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
