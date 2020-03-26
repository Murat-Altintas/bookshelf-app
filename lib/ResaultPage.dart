import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grade_point_avarage/masterpage.dart';
import 'model/book.dart';
import 'style.dart';

class ResaultPage extends StatefulWidget {
  @override
  _ResaultPageState createState() => _ResaultPageState();
}

class _ResaultPageState extends State<ResaultPage> {
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
                  //return allBook.items;
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
                // print(allBook[0].items);
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
            SizedBox(
              height: heightSize(2),
            ),
            Container(
              height: heightSize(55),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                children: <Widget>[
                    if(allBook != null)
                    for (int i = 0; i < allBook.items.length; i++)
                      FittedBox(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
