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
          color: Colors.white,
          fontFamily: 'MainFont',
          fontWeight: FontWeight.w700,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'would \n',
            style: TextStyle(
              fontSize: heightSize(6),
              color: Colors.white,
              fontFamily: 'MainFont',
              fontWeight: FontWeight.w300,
            ),
          ),
          TextSpan(
            text: 'you like to \n',
            style: TextStyle(
              fontSize: heightSize(6),
              color: Colors.white,
              fontFamily: 'MainFont',
              fontWeight: FontWeight.w300,
            ),
          ),
          TextSpan(
            text: 'learn today?',
            style: TextStyle(
              height: heightSize(0.22),
              fontSize: heightSize(6),
              color: Colors.white,
              fontFamily: 'MainFont',
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
    searchBar() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: widthSize(77),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20, top: 3),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    borderSide: BorderSide(color: Colors.yellow, width: 1),
                  ),
                  hintText: "Search your book...",
                  hintStyle: search,
                ),
              ),
            ),
          ],
        );

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
    return Scaffold(
      body: Stack(
        children: <Widget>[
          bgGradient,
          Positioned(
            top: heightSize(42),
            child: Container(
              width: SizeConfig.screenWidth,
              height: heightSize(70),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),
          Positioned(
            top: heightSize(7),
            left: widthSize(12),
            child: titleText,
          ),
          Positioned(
            top: heightSize(4),
            left: widthSize(54),
            height: heightSize(26),
            child: Image.asset("assets/images/resaultPage.png"),
          ),
          Positioned(
            top: heightSize(32),
            left: widthSize(12),
            child: searchBar(),
          ),
          Column(
            children: <Widget>[
            ],
          ),
        ],
      ),
    );
  }
}
