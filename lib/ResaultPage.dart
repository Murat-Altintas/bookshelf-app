import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grade_point_avarage/MasterPage.dart';
import 'View/Images/ResaultImage.dart';
import 'package:grade_point_avarage/View/ContextExtension.dart';
import 'init/theme/BlueTheme.dart';
import 'model/book.dart';

class ResaultPage extends StatefulWidget {
  @override
  _ResaultPageState createState() => _ResaultPageState();
}

class _ResaultPageState extends State<ResaultPage> {
  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Item> loadedItems = [];
  int startIndex = 0;
  var bookName = TextEditingController();

  getData(String bookName) async {
    var dio = Dio();
    var response = await dio.get(
        "https://www.googleapis.com/books/v1/volumes?q=$bookName+&langRestrict=tr&maxResults=10&startIndex=$startIndex"); //&maxResults=10&startIndex=$startIndex");
    Map data = await response.data;
    final booksResponse = Book.fromJson(data);
    // add more items.
    loadedItems.addAll(booksResponse.items);

    setState(() {});
  }

  //------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ResaultImage(),
            searchBar(),
            SizedBox(
              height: context.lowestContainer,
            ),
            Expanded(
                child: Column(
              children: <Widget>[
                CarouselSlider.builder(
                  itemCount: loadedItems.length,
                  options: CarouselOptions(
                      onPageChanged: (page, reason) {
                        if (page == loadedItems.length - 1) {
                          loadNextPage();
                          print("+10 page");
                        }
                      },
                      pauseAutoPlayOnTouch: true,
                      disableCenter: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.scale,
                      enlargeCenterPage: true,
                      viewportFraction: 0.6,
                      enableInfiniteScroll: false,
                      autoPlay: false,
                      autoPlayInterval: Duration(seconds: 4),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.decelerate,
                      height: context.height * 57),
                  itemBuilder: (BuildContext context, int index) {
                    Widget changeIcon = Icon(Icons.favorite_border);
                    return Container(
                        width: context.height * 55,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Ink(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                child: loadedItems[index].volumeInfo.imageLinks != null
                                    ? Image.network(
                                        loadedItems[index].volumeInfo.imageLinks.thumbnail,
                                        height: context.height * 35,
                                        fit: BoxFit.fill,
                                      )
                                    : Center(child: Text("NO IMAGE", style: blueTheme.textTheme.headline1)),
                                height: context.height * 30,
                              ),
                              SizedBox(
                                height: context.lowestContainer,
                              ),
                              Text(
                                loadedItems[index].volumeInfo.title == null ? "No data" : loadedItems[index].volumeInfo.title.toUpperCase(),
                                style: blueTheme.primaryTextTheme.headline1.copyWith(fontSize: context.lowText),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              Text(
                                loadedItems[index].volumeInfo.authors.toString() == null
                                    ? "No data"
                                    : loadedItems[index].volumeInfo.authors.toString().replaceAll("]", "").replaceAll("[  ", ""),
                                style: blueTheme.primaryTextTheme.headline2.copyWith(fontSize: context.lowText),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                loadedItems[index].volumeInfo.publisher.toString() == null
                                    ? "No data"
                                    : loadedItems[index].volumeInfo.publisher.toString(),
                                style: blueTheme.primaryTextTheme.headline3.copyWith(fontSize: context.lowText),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: context.height * 1,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  IconButton(
                                    icon: changeIcon,
                                    color: blueTheme.errorColor,
                                    onPressed: () {
                                      setState(() {
                                        if (changeIcon == Icon(Icons.favorite_border)) {
                                          changeIcon = Icon(Icons.favorite);
                                        } //_saveBookTitle(loadedItems[index]);
                                      });
                                    },
                                    iconSize: 30,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.check_box_outline_blank),
                                    onPressed: () {},
                                    iconSize: 30,
                                    color: blueTheme.primaryColor,
                                  ),
                                  Text(
                                    "Sayfa sayısı: " + loadedItems[index].volumeInfo.pageCount.toString(),
                                    style: blueTheme.primaryTextTheme.headline3,
                                  ),
                                ],
                              ),
                            ],
                          ),
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
                  borderSide: BorderSide(color: blueTheme.primaryColor, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(60)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(60.0)),
                  borderSide: BorderSide(color: blueTheme.primaryColor, width: 1),
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
            iconSize: context.iconSize,
            color: blueTheme.primaryIconTheme.color,
            onPressed: () async {
              getData(bookName.text);
            },
          ),
        ],
      );

  Future<void> _saveBookTitle(allBook) async {
    Map<String, String> idMap = Map();
    idMap[allBook.id] = allBook.id;
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;

    String title = allBook.volumeInfo.title == null ? "NO DATA" : allBook.volumeInfo.title.toString();
    String authors = allBook.volumeInfo.authors == null ? "NO DATA" : allBook.volumeInfo.authors.first.toString();
    String publisher = allBook.volumeInfo.publisher == null ? "NO DATA" : allBook.volumeInfo.publisher.toString();
    String image = allBook.volumeInfo.imageLinks == null ? "NO DATA" : allBook.volumeInfo.imageLinks.thumbnail.toString();

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

  void loadNextPage() {
    startIndex += 10;
    getData(bookName.text);
  }
}
