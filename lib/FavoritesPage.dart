import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MobileBookshelf/repository/UserRepository.dart';
import 'MasterPage.dart';
import 'model/book.dart';
import 'model/firebaseBook.dart';
import 'init/theme/BlueTheme.dart';
import 'View/ContextExtension.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Item> loadedItems = [];

  @override
  Widget build(BuildContext context) {
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
              Column(
                children: <Widget>[
                  Container(
                    height: context.height * 30,
                    child: Image.asset("assets/images/favoritesPage.png"),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: blueTheme.primaryColor,
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MasterPage()));
                          }),
                      titleText,
                    ],
                  ),
                ],
              ),
              FutureBuilder<List<FirebaseBook>>(
                future: UserRepository().getFavoriteBooks(),
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
                      return Expanded(
                        child: ListView.builder(
                            itemCount: dataSnapShot.data.length,
                            itemBuilder: (context, index) {
                              final model = dataSnapShot.data[index];
                              return Padding(
                                padding: context.paddingMedium,
                                child: Column(
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
                                              child: model.image.isEmpty ? Text("NO DATA") : Image.network(model.image),
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
                                                  Text(
                                                    model.title,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: blueTheme.textTheme.headline1.copyWith(fontSize: context.normalText),
                                                  ),
                                                  // always test the code.
                                                  Text(
                                                    model.authors,
                                                    style: blueTheme.textTheme.headline2.copyWith(fontSize: context.lowText),
                                                  ),
                                                  SizedBox(height: context.lowestContainer),
                                                  Text(
                                                    model.publisher,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.delete),
                                              color: blueTheme.errorColor,
                                              onPressed: () {
                                                UserRepository().deleteBook(model.bookID, true).whenComplete(() {
                                                  setState(() {});
                                                });
                                                print("delete complete");
                                              },
                                              iconSize: 30,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: context.lowestContainer,
                                    ),
                                  ],
                                ),
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

/*
  Future<List<Map<String, dynamic>>> bookFill() async {
    final User user = _auth.currentUser;
    final uid = user.uid;
    try {
      List<Map<String, dynamic>> idMap = [];
      await _firestore.collection("$uid").get().then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((f) {
          idMap.add(f.data());
          // print('this is the data:::: ${f.data}');
        });
      });
      return idMap;
    } catch (e) {
      print(e);
      return null;
    }
  }

 */
}
