import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model/book.dart';
import 'dart:convert';

class BookshelfPage extends StatefulWidget {
  @override
  _BookshelfPageState createState() => _BookshelfPageState();
}

class _BookshelfPageState extends State<BookshelfPage> {

  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Book allBook;

  var bookName = TextEditingController();

  getData(String bookName, pageIndex) async {
    var dio = Dio();
    var response = await dio.get(
        "https://www.googleapis.com/books/v1/volumes?maxResults=100&q=$bookName");
    //https://www.googleapis.com/books/v1/volumes?q=selam&maxResults=40&startIndex=2

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
              Container(
                child: Expanded(
                  child: FutureBuilder(
                    future: getBooks(), //future döndüren metod
                    builder: (context,
                        AsyncSnapshot<List<Map<String, dynamic>>>
                        dataSnapShot) {
                      // gelen verinin türünü belirtmezsen length seçemezsin
                      if (dataSnapShot.connectionState ==
                          ConnectionState.done) {
                        print('the data is:');
                        print(jsonEncode(dataSnapShot.data));
                        List<String> titleList = [];
                        List<String> imgList = [];
                        List<String> authorsList = [];
                        List<String> publisherList = [];
                        // gelen map tipindeki veriyi liste tipine dönüştürüyoruz çünkü ListView'de "listeismi.[index]" şeklinde veri işlenir.
                        dataSnapShot.data.forEach((a) {
                          a.forEach((x, y) {
                            if (x == "image") imgList.add(y);
                            if (x == "title") titleList.add(y);
                            if (x == "authors") authorsList.add(y);
                            if (x == "publisher") publisherList.add(y);
                          });
                        });
                        return ListView.builder(
                          itemCount: titleList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: <Widget>[
                                Container(
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
                                  padding: EdgeInsets.only(
                                      left: widthSize(5), right: widthSize(5)),
                                  height: heightSize(25),
                                  width: widthSize(90),
                                  child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          height: heightSize(35),
                                          child: Image.network(
                                              imgList[index]), //imgList is here
                                        ),
                                      ),
                                      SizedBox(
                                        width: widthSize(3),
                                      ),
                                      Expanded(
                                        flex: 9,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text(
                                                titleList[
                                                index], //titleList is here        //titleList is here//titleList is here//titleList is here//titleList is here//titleList is here
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: heightSize(2),
                                                  color: Colors.lightBlue,
                                                  fontFamily: 'MainFont',
                                                  fontWeight: FontWeight.w700,
                                                )),
                                            Text(
                                              authorsList[
                                              index], //authorsList is here
                                              style: TextStyle(
                                                fontSize: heightSize(2),
                                                color: Colors.purple,
                                              ),
                                            ),
                                            SizedBox(
                                              height: heightSize(2),
                                            ),
                                            Text(
                                              //fena mı çok can yakıcı :D oldu heralde şimdilik oldu knk eline sağlık da bunun
                                              // daha kolay bi yolu yordamı var mıdır acaba ya böyle çok uğraştın sanki?
                                              //bilmiyom vardır belki hm tmm knk çok teşekkür ederim zor olayları hallettik
                                              //sırada daha zor olaylar var :D :d
                                              //bu  hafta kendi projeme bakmaya baslıcam , tasarımda danısırım sana ona göre
                                              // knk ayıpsn ya tasrım senin civcivin olsun :D :D
                                              // ya şimdi malum bu favorileri yazdırdık eyvallah da bunu tabi kullanıcıya has yapmak lazım
                                              // onla uğraşcam ben ama sen nezamna tasarıma başlayalım dersen bn kendi projemi bırakır ona başlarım
                                              //sıkıntı yok yani anladım, benim 2-3 haftaya okul da bitcek onun için tezi yetiştirmem lazım
                                              // tmm knk seni rahatsız etmem bitene kadar enazından :D tmm tmm anlaştık hadi bana müsaade
                                              // çok teşekkür ederim Allah razı olsn knk görüşürz eline sağlık cümlemizden görüşürz
                                              publisherList[
                                              index], //publisherList is here
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: heightSize(3),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getBooks() async {

    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    try {
      List<Map<String, dynamic>> idMap = [];
      await _firestore
          .collection("$uid")
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          idMap.add(f.data);
          print('this is the data:::: ${f.data}');
        });
      });
      return idMap;
    } catch (e) {
      print(e);
      return null;
    }

    /*
    //get() ile documentsnapshot geliyor bu bizim verimiz değil aslında, verimiz içerisinde

    return await firestore.collection("bookrequest").document("documentName").get().then((data) {
      return data.data; // snapshot içindeki verimizi return ediyoruz
    });
     */
  }
}
