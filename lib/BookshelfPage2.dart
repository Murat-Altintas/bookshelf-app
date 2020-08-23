import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'MasterPage.dart';
import 'model/firebaseBook.dart';
import 'init/theme/BlueTheme.dart';
import 'View/ContextExtension.dart';

class BookshelfPage2 extends StatefulWidget {
  @override
  _BookshelfPage2State createState() => _BookshelfPage2State();
}

class _BookshelfPage2State extends State<BookshelfPage2> {
  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    print("AWESOME TO BE HERE!");
    var titleText = RichText(
      text: TextSpan(
        text: "My ",
        style: blueTheme.textTheme.headline1.copyWith(fontSize: context.normalText),
        children: <TextSpan>[
          TextSpan(
            text: 'favorite books...',
            style: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
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
                height: context.height * 33,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: context.height * 25,
                      child: Image.asset("assets/images/bookshelfPage.png"),
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: blueTheme.primaryColor,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => MasterPage()));
                            }),
                        titleText,
                      ],
                    ),
                  ],
                ),
              ),
              FutureBuilder<List<FirebaseBook>>(
                future: showBooks(),
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
                                    child: Padding(
                                      padding: context.paddingMedium,
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(
                                            child: Image.network(model.image),
                                            height: context.height * 20,
                                            width: context.width * 20,
                                          ),
                                          SizedBox(
                                            width: context.lowestContainer,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(model.title,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: blueTheme.textTheme.headline1
                                                        .copyWith(fontSize: context.normalText)),
                                                // always test the code.
                                                Text(model.authors,
                                                    style: blueTheme.textTheme.headline2
                                                        .copyWith(fontSize: context.lowText)),
                                                SizedBox(height: context.lowestContainer),
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
                                  ),
                                  SizedBox(
                                    height: context.lowestContainer,
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

  Future<List<FirebaseBook>> showBooks() async {
    final FirebaseUser user = await _auth.currentUser();
    return (await _firestore.collection(user.uid).getDocuments())
        .documents
        .map((doc) => FirebaseBook.fromJson(doc.data))
        .toList();
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
