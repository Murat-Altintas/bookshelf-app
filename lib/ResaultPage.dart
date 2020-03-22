import 'package:flutter/material.dart';
import 'style.dart';

class ResaultPage extends StatefulWidget {
  @override
  _ResaultPageState createState() => _ResaultPageState();
}

class _ResaultPageState extends State<ResaultPage> {
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
              height: heightSize(0.22),
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
          children: <Widget>[
            Container(
              width: widthSize(80),
              child: TextField(
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
              iconSize: heightSize(6),
              color: Colors.purple,
              onPressed: () {},
            ),
          ],
        );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Stack(
              overflow: Overflow.visible,
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
                Positioned(
                  top: heightSize(35),
                  left: widthSize(5),
                  child: searchBar(),
                ),
                Column(
                  children: <Widget>[

                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
