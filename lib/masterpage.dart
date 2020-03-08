import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ResaultPage.dart';
import 'style.dart';

class MasterPage extends StatefulWidget {
  @override
  MasterPageState createState() => MasterPageState();
}

class MasterPageState extends State<MasterPage> {
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
    var bgGradient = Container(
      child: Padding(
        padding: const EdgeInsets.all(20),
      ),
      height: heightSize(100),
      width: widthSize(100),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.1, 1],
              colors: [Colors.purple.shade300, Colors.pink.shade300])),
    );
    var welcome = RichText(
      text: TextSpan(
        text: "Welcome",
        style: TextStyle(
          fontSize: heightSize(4),
          color: Colors.purple,
          fontFamily: 'MainFont',
          fontWeight: FontWeight.w700,
        ),
        children: <TextSpan>[
          TextSpan(
            text: ' to your bookshelf...',
            style: TextStyle(
              fontSize: heightSize(4),
              color: Colors.purple,
              fontFamily: 'MainFont',
              fontWeight: FontWeight.w300,
            ),
          )
        ],
      ),
    );
    var user = RichText(
      text: TextSpan(
        text: "Hello",
        style: TextStyle(
          fontSize: heightSize(4),
          color: Colors.purple,
          fontFamily: 'MainFont',
          fontWeight: FontWeight.w700,
        ),
        children: <TextSpan>[
          TextSpan(
            text: ' Murat Altintas',
            style: TextStyle(
              fontSize: heightSize(4),
              color: Colors.purple,
              fontFamily: 'MainFont',
              fontWeight: FontWeight.w300,
            ),
          )
        ],
      ),
    );

    var mainIcon = TextStyle(
      fontSize: heightSize(2.5),
      color: Colors.white,
      fontFamily: 'MainFont',
      fontWeight: FontWeight.w700,
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: heightSize(3),
            ),
            Center(
              child: SizedBox(
                height: heightSize(37),
                child: Image.asset("assets/images/topsearch.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: heightSize(3),
                  ),
                  Row(
                    children: <Widget>[
                      welcome,
                    ],
                  ),
                  SizedBox(
                    height: heightSize(1.5),
                  ),
                  Row(
                    children: <Widget>[
                      user,
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(35),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResaultPage()));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        color: Colors.lightBlueAccent,
                        width: widthSize(40),
                        height: heightSize(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              height: heightSize(20),
                              child: Image.asset("assets/images/my_search.png"),
                            ),
                            Text(
                              "MY SEARCH",
                              style: mainIcon,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: widthSize(5),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResaultPage()));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        color: Colors.purple,
                        width: widthSize(40),
                        height: heightSize(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              height: heightSize(20),
                              child:
                                  Image.asset("assets/images/my_bookshelf.png"),
                            ),
                            Text(
                              "MY BOOKSHELF",
                              style: mainIcon,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: widthSize(5),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResaultPage()));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        color: Colors.pinkAccent,
                        width: widthSize(40),
                        height: heightSize(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              height: heightSize(20),
                              child:
                                  Image.asset("assets/images/my_favorites.png"),
                            ),
                            Text(
                              "MY FAVORITES",
                              style: mainIcon,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: widthSize(5),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResaultPage()));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        color: Colors.orangeAccent,
                        width: widthSize(40),
                        height: heightSize(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              height: heightSize(20),
                              child: Image.asset(
                                  "assets/images/my_acquisitions.png"),
                            ),
                            Text(
                              "MY ACQUISITIONS",
                              style: mainIcon,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: widthSize(5),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResaultPage()));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        color: Colors.redAccent,
                        width: widthSize(40),
                        height: heightSize(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              height: heightSize(20),
                              child: Image.asset("assets/images/my_notes.png"),
                            ),
                            Text(
                              "MY NOTES",
                              style: mainIcon,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: widthSize(5),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResaultPage()));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        color: Colors.deepPurpleAccent,
                        width: widthSize(40),
                        height: heightSize(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              height: heightSize(20),
                              child:
                                  Image.asset("assets/images/my_options.png"),
                            ),
                            Text(
                              "MY OPTIONS",
                              style: mainIcon,
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

/*

InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ResaultPage()));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Container(
                  color: Colors.purple,
                  width: widthSize(40),
                  height: heightSize(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        height: heightSize(20),
                        child: Image.asset("assets/images/my_bookshelf.png"),
                      ),
                      Text(
                        "My Bookshelf",
                        style: TextStyle(
                          fontSize: heightSize(2.5),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
 */
