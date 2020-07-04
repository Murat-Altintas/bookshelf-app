import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MasterPage.dart';
import 'model/book.dart';

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
                            icon: Icon(Icons.arrow_back_ios, color: Colors.blue,),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MasterPage()));
                            }),
                        titleText,
                      ],
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
                        child: Text("An error occured!"),
                      );
                    } else {
                      var titleList = dataSnapShot.data;
                      // List<String> titleList = dataSnapShot.data.documents.toList(); // benimkine benziyor işte map i liste çevirmiş
                      return Expanded(
                        child: ListView.builder(
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
                                    padding: EdgeInsets.only(left: widthSize(5), right: widthSize(5)),
                                    height: heightSize(25),
                                    width: widthSize(90),
                                    child: Row(
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            height: heightSize(35),
                                            //child: imgList[index],  //imgList is here
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
                                              Text(titleList[index]["title"], //titleList is here
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: heightSize(2),
                                                    color: Colors.lightBlue,
                                                    fontFamily: 'MainFont',
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                              Text(
                                                ("test"),
                                                // authorsList[index],  //authorsList is here
                                                style: TextStyle(
                                                  fontSize: heightSize(2),
                                                  color: Colors.purple,
                                                ),
                                              ),
                                              SizedBox(
                                                height: heightSize(2),
                                              ),
                                              Text(
                                                ("test"),
                                                // publisherList[index],  //publisherList is here
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

  Future<List<Map<String, dynamic>>> bookFill() async {
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    try {
      List<Map<String, dynamic>> idMap = [];
      await _firestore.collection("$uid").getDocuments().then((QuerySnapshot snapshot) {
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
