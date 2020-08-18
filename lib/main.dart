import 'package:flutter/material.dart';
import 'package:grade_point_avarage/BookshelfPage2.dart';
import 'package:grade_point_avarage/CreateAccount.dart';
import 'package:grade_point_avarage/MasterPage.dart';
import 'package:grade_point_avarage/ResaultPage.dart';
import 'package:provider/provider.dart';

import 'LoginPage.dart';

void main() => runApp(GradePoint());

class GradePoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: MasterPage(),
    );
  }
}

/*
FractionallySizedBox(), // widthFactor: 0,7 vermek mevcut child boyutunun %70'i demek.
SizedBox(),
FlexFit(),
Flex(),
Flexible(),
FittedBox(),
Spacer(),
 */

/*
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
 */

/*
Container(
                child: Expanded(
                  child: FutureBuilder(
                    future: getBooks(), //future döndüren metod
                    builder: (context, AsyncSnapshot<Map<String, dynamic>> dataSnapShot) {
                      // gelen verinin türünü belirtmezsen length seçemezsin
                      if (dataSnapShot.connectionState == ConnectionState.done) {
                        List<String> titleList = [];
                        // gelen map tipindeki veriyi liste tipine dönüştürüyoruz çünkü ListView'de "listeismi.[index]" şeklinde veri işlenir.
                        dataSnapShot.data.forEach((a, b) {
                          titleList.add(b); //burada verileri books listesine attık
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
                                          //child: imgList[index],                                //imgList is here
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
                                            Text(titleList[index],                                //titleList is here
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: heightSize(2),
                                                  color: Colors.lightBlue,
                                                  fontFamily: 'MainFont',
                                                  fontWeight: FontWeight.w700,
                                                )),
                                            Text(
                                              ("test"),
                                              // authorsList[index],                               //authorsList is here
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
                                              // publisherList[index],                            //publisherList is here
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
 */

/*
var title = CommonStyledTitle(
  boldText: 'Welcome',
  normalText: ' to your bookshelf...',
  color: Colors.purple,
  fontSize: 3.yr,
);
 */
