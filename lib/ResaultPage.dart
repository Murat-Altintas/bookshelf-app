import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grade_point_avarage/MasterPage.dart';
import 'model/book.dart';
import 'style.dart';

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
    var titleText = RichText(
      text: TextSpan(
        text: "What ",
        style: TextStyle(
          fontSize: heightSize(4),
          color: Colors.lightBlue,
          fontFamily: 'MainFont',
          fontWeight: FontWeight.w700,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'would \n',
            style: TextStyle(
              fontSize: heightSize(4),
              color: Colors.lightBlue,
              fontFamily: 'MainFont',
              fontWeight: FontWeight.w300,
            ),
          ),
          TextSpan(
            text: 'you like to \n',
            style: TextStyle(
              fontSize: heightSize(4),
              color: Colors.lightBlue,
              fontFamily: 'MainFont',
              fontWeight: FontWeight.w300,
            ),
          ),
          TextSpan(
            text: 'learn today?',
            style: TextStyle(
              height: heightSize(0.15),
              fontSize: heightSize(4),
              color: Colors.lightBlue,
              fontFamily: 'MainFont',
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
    void _veriEkle() {
      Map<String, dynamic> emreEkle = Map();
      emreEkle["ad"] = "emre updated";
      emreEkle["lisansMezunu2"] = true;
      emreEkle["lisansMezunu4"] = true;
      emreEkle["okul"] = "ege";
      _firestore
          .collection("users")
          .document("emre_altunbilek")
          .setData(emreEkle, merge: true)
          .then((v) => debugPrint("emre eklendi"));

      Map<String, dynamic> muratEkle = Map();
      muratEkle["ad"] = "murat";
      muratEkle["önlisansMezunu"] = true;

      _firestore
          .collection("users")
          .document("hasan_yilmaz")
          .setData(muratEkle)
          .whenComplete(() => debugPrint("murat eklendi"));

      _firestore.document("/users/ayse").setData({"ad": "ayse"});

      _firestore.collection("users").add({"ad": "can", "yas": 35});

      String yeniKullaniciID =
          _firestore
              .collection("users")
              .document()
              .documentID;
      debugPrint("yeni doc id: $yeniKullaniciID");
      _firestore.document("users/$yeniKullaniciID").setData({"yas": 30});
    }

    searchBar() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: heightSize(5),
          color: Colors.purple,
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
                    top: heightSize(9),
                    left: widthSize(8),
                    child: titleText,
                  ),
                  Positioned(
                    left: widthSize(43),
                    top: heightSize(2),
                    child: Container(
                        height: heightSize(25),
                        child: Image.asset("assets/images/resaultPage.png")),
                  ),
                ],
              ),
            ),
            searchBar(),
            /*
            Container(
              height: 50,
              width: 50,
              child: IconButton(
                icon: Icon(Icons.search),
                iconSize: heightSize(5),
                color: Colors.purple,
                onPressed: () {
                  _veriEkle();
                },
              ),
            ),
             */
            SizedBox(
              height: heightSize(2),
            ),
            Container(
              height: heightSize(55),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                children: <Widget>[
                  if (allBook != null)
                    for (int i = 0; i < allBook.items.length; i++)
                      GestureDetector(
                        onTap: () => _saveSelectedBook(allBook.items[i]),
                        child: FittedBox(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              width: widthSize(60),
                              color: Colors.blueGrey.shade100,
                              child: Column(
                                children: <Widget>[
                                  allBook.items[i].volumeInfo.imageLinks
                                      .thumbnail ==
                                      null
                                      ? null
                                      : Container(
                                    child: Image.network(
                                      "${allBook.items[i].volumeInfo.imageLinks.thumbnail}",
                                    ),
                                  ),
                                  SizedBox(
                                    height: heightSize(1),
                                  ),
                                  Text(
                                    //"${allBook.items[i].volumeInfo}",
                                    "${allBook.items[i].volumeInfo.title.toUpperCase()}",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.lightBlue,
                                      fontSize: heightSize(2.5),
                                      fontFamily: 'MainFont',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    "${allBook.items[i].volumeInfo.authors == null ? null : allBook.items[i].volumeInfo.authors.first}",
                                    style: TextStyle(
                                      fontSize: heightSize(2),
                                      color: Colors.purple,
                                      fontFamily: 'MainFont',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: heightSize(1),
                                  ),
                                  Text(
                                    "${allBook.items[i].volumeInfo.publisher}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: heightSize(2),
                                      fontFamily: 'MainFont',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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


  void _saveSelectedBook(selectedBook) {
    Map<String, String> bookMap = Map();

    bookMap[selectedBook.id] = selectedBook.volumeInfo.title;

    _firestore
        .collection("booktest")
        .document("books")
        .setData(bookMap, merge: true);
  }
}
