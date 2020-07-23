import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'MasterPage.dart';
import 'model/firebaseBook.dart';

class BookshelfPage2 extends StatefulWidget {
  @override
  _BookshelfPage2State createState() => _BookshelfPage2State();
}

class _BookshelfPage2State extends State<BookshelfPage2> {
  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    print("AWESOME TO BE HERE!");
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
                child: Column(
                  children: <Widget>[
                    Container(
                      height: heightSize(25),
                      child: Image.asset("assets/images/bookshelfPage.png"),
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MasterPage()));
                            }),
                        titleText,
                      ],
                    ),
                  ],
                ),
              ),
              FutureBuilder<List<FirebaseBook>>(
//                future: bookFill(),
                future: getBooks(),
                builder: (context, dataSnapShot) {
                  if (dataSnapShot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (dataSnapShot.error != null) {
                      return Center(
                        child: Text("An error occured!"),
                      );
                    } else {
                      final titleList = dataSnapShot.data;
                      return Expanded(
                        child: ListView.builder(
                            itemCount: titleList.length,
                            itemBuilder: (context, index) {
                              final model = titleList[index];
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
                                        left: widthSize(5),
                                        right: widthSize(5)),
                                    height: heightSize(25),
                                    width: widthSize(90),
                                    child: Row(
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            height: heightSize(35),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image:
                                                    NetworkImage(model.image),
                                              ),
                                            ),
                                            //child: imgList[index],  //imgList is here
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
                                                  model.title,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: heightSize(2),
                                                    color: Colors.lightBlue,
                                                    fontFamily: 'MainFont',
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                              // always test the code.
                                              Text(
                                                model.authors,
                                                style: TextStyle(
                                                  fontSize: heightSize(2),
                                                  color: Colors.purple,
                                                ),
                                              ),
                                              SizedBox(
                                                height: heightSize(2),
                                              ),
                                              Text(
                                                model.publisher,
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
                            }),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<FirebaseBook>> getBooks() async {
    final FirebaseUser user = await _auth.currentUser();
    return (await _firestore.collection(user.uid).getDocuments()).documents.map((doc) => FirebaseBook.fromJson(doc.data)).toList();
  }

  Future<List<Map<String, dynamic>>> bookFill() async {
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
          // print('this is the data:::: ${f.data}');
        });
      });
      return idMap;
    } catch (e) {
      print(e);
      return null;
    }
  }
}