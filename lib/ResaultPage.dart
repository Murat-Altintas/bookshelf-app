import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model/book.dart';
import 'style.dart';

class ResaultPage extends StatefulWidget {
  @override
  _ResaultPageState createState() => _ResaultPageState();
}

class _ResaultPageState extends State<ResaultPage> {
  Book allBook;

  var bookName = TextEditingController();

  void getData(String bookName) async {
    var dio = Dio();
    var response = await dio
        .get("https://www.googleapis.com/books/v1/volumes?q=$bookName");

    Map data = await response.data;
    print(data);

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

  @override
  Widget build(BuildContext context) {
    var titleText = RichText(
      text: TextSpan(
        text: "What ",
        style: TextStyle(
          fontSize: heightSize(6),
          color: Colors.lightBlue,
          fontFamily: 'MainFont',
          fontWeight: FontWeight.w700,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'would \n',
            style: TextStyle(
              fontSize: heightSize(6),
              color: Colors.lightBlue,
              fontFamily: 'MainFont',
              fontWeight: FontWeight.w300,
            ),
          ),
          TextSpan(
            text: 'you like to \n',
            style: TextStyle(
              fontSize: heightSize(6),
              color: Colors.lightBlue,
              fontFamily: 'MainFont',
              fontWeight: FontWeight.w300,
            ),
          ),
          TextSpan(
            text: 'learn today?',
            style: TextStyle(
              height: heightSize(0.15),
              fontSize: heightSize(6),
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
            Container(
              width: widthSize(75),
              child: TextField(
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
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: heightSize(32),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: heightSize(9),
                    left: widthSize(5),
                    child: titleText,
                  ),
                  Positioned(
                    left: widthSize(50),
                    top: heightSize(2),
                    child: Container(
                        height: heightSize(30),
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
              height: heightSize(52),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                shrinkWrap: true,
                children: <Widget>[
                  if (allBook != null)
                    for (int i = 0; i < allBook.items.length; i++)
                      FittedBox(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: widthSize(65),
                            color: Colors.blueGrey.shade50,
                            child: Column(
                              children: <Widget>[
                                allBook.items[i].volumeInfo.imageLinks
                                            .thumbnail !=
                                        null
                                    ? Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.indigo.withOpacity(0.5),
                                              spreadRadius: 3,
                                              blurRadius: 5,
                                              offset: Offset(4.0, 4.0),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          child: Image.network(
                                              "${allBook.items[i].volumeInfo.imageLinks.thumbnail}"),
                                        ),
                                      )
                                    : null,
                                SizedBox(
                                  height: heightSize(1),
                                ),
                                Text(
                                  "${allBook.items[i].volumeInfo.title.toUpperCase()}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.lightBlue,
                                    fontSize: heightSize(2.5),
                                    fontFamily: 'MainFont',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "${allBook.items[i].volumeInfo.authors == null ? null : allBook.items[i].volumeInfo.authors.first.toUpperCase()}",
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
                                  "${allBook.items[i].volumeInfo.publisher.toUpperCase()}",
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
