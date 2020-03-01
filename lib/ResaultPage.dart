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
    searchBar() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: widthSize(75),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20, top: 3),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    borderSide: BorderSide(color: Colors.purple, width: 1),
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
            top: heightSize(30),
            child: Container(
              width: SizeConfig.screenWidth,
              height: heightSize(60),
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
            left: widthSize(10),
            top: heightSize(7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("What would you like/Nto learn today?"),
                SizedBox(
                  height: heightSize(20),
                  child: Image.asset("assets/images/resaultPage.png"),
                ),
              ],
            ),
          ),
          Positioned(
            top: heightSize(5),
            left: widthSize(12),
            child: searchBar(),
          ),
        ],
      ),
    );
  }
}
