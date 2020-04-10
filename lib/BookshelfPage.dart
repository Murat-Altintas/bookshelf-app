import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grade_point_avarage/MasterPage.dart';
import 'model/book.dart';
import 'style.dart';
import 'dart:convert';

class BookshelfPage extends StatefulWidget {
  @override
  _BookshelfPageState createState() => _BookshelfPageState();
}

class _BookshelfPageState extends State<BookshelfPage> {
  final Firestore firestore = Firestore.instance;

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
    var bookData = firestore.collection("booktest").document("books").get();
    var titleText = RichText(
      text: TextSpan(
        text: "My ",
        style: TextStyle(
          fontSize: heightSize(4),
          color: Colors.lightBlue,
          fontFamily: 'MainFont',
          fontWeight: FontWeight.w700,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'current books...',
            style: TextStyle(
              fontSize: heightSize(4),
              color: Colors.lightBlue,
              fontFamily: 'MainFont',
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: heightSize(35),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: heightSize(27),
                      child: titleText,
                    ),
                    Positioned(
                      child: Container(
                        height: heightSize(25),
                        child: Image.asset("assets/images/bookshelfPage.png"),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: bookFill(),
                builder: (context, dataSnapShot) {
                  if (dataSnapShot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (dataSnapShot.error != null) {
                      return Center(
                        child: Text("Bir hata meydana geldi"),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: dataSnapShot.data,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(dataSnapShot.data),
                            );
                          });
                    }
                  }
                },
              ),
              Container(
                width: 30,
                height: 30,
                child: IconButton(
                  icon: Icon(Icons.search),
                  iconSize: heightSize(5),
                  color: Colors.purple,
                  onPressed: () async {
                    readTest();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveSelectedBook(selectedBook) {
    Map<String, String> bookMap = Map();

    bookMap[selectedBook.id] = selectedBook.volumeInfo.title;

    firestore.collection("booktest").document("books").setData(bookMap, merge: true);
  }

  readTest() async {
    //tek bir dökümanın okunması
    DocumentSnapshot documentSnapshot = await firestore.document("booktest/books").get();
    debugPrint("Döküman id:" + documentSnapshot.documentID);
    debugPrint("Döküman var mı:" + documentSnapshot.exists.toString());
    debugPrint("Döküman string:" + documentSnapshot.toString());
    debugPrint("bekleyen yazma var mı:" + documentSnapshot.metadata.hasPendingWrites.toString());
    debugPrint("cacheden mi geldi:" + documentSnapshot.metadata.isFromCache.toString());
    debugPrint("cacheden mi geldi:" + documentSnapshot.data["5uRIb3emLY8C"].toString());
    documentSnapshot.data.forEach((key, deger) {
      debugPrint("key: $key deger: $deger");
    });

    firestore.collection("booktest").getDocuments().then((querySnapshots) {
      debugPrint("Booktest colldeki eleman sayısı:" + querySnapshots.documents.length.toString());

      for (int i = 0; i < querySnapshots.documents.length; i++) {
        debugPrint("Document uzunluğu: " + querySnapshots.documents[i].data.toString());
      }

      //anlık değişikliklerin dinlenmesi
      DocumentReference ref = firestore.collection("booktest").document("books");
      ref.snapshots().listen((degisenVeri) {
        debugPrint("anlık :" + degisenVeri.data.toString());
      });

      firestore.collection("booktest").snapshots().listen((snap) {
        debugPrint(snap.documents.length.toString());
      });
    });
  }

  Future bookFill() async {
    DocumentSnapshot documentSnapshot = await firestore.document("booktest/books").get();

    return documentSnapshot.data;
  }
}
