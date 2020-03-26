import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}

class styles extends StatefulWidget {
  @override
  _stylesState createState() => _stylesState();
}





class _stylesState extends State<styles> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[],);
  }
}


var mainBlue = Colors.blue;
var mainGrey = Colors.blueGrey;

var iconSize = SizeConfig.blockSizeVertical * 3.5;
var titleSize = SizeConfig.blockSizeVertical * 3;
var titleColor = Colors.red;

var title = TextStyle(
  fontFamily: 'MainFont',
  fontWeight: FontWeight.w700,
  fontSize: 30,
  color: mainBlue,
);

var username = TextStyle(
  fontFamily: 'MainFont',
  fontWeight: FontWeight.w500,
  fontSize: 20,
  color: mainBlue,
);


var login = TextStyle(
  fontFamily: 'MainFont',
  fontWeight: FontWeight.w500,
  fontSize: 20,
  color: Colors.white,
);

var knowledge = TextStyle(
  fontFamily: 'MainFont',
  fontWeight: FontWeight.w500,
  fontSize: 20,
  color: mainBlue,
);

var search = TextStyle(

  fontFamily: 'MainFont',
  fontWeight: FontWeight.w300,
  fontSize: 17,
  color: Colors.lightBlue,
);