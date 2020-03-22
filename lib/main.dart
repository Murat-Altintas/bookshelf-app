import 'package:grade_point_avarage/OptionsPage.dart';
import 'package:grade_point_avarage/masterpage.dart';
import 'ResaultPage.dart';
import 'loginpage.dart';
import 'loginpage2.dart';
import 'style.dart';
import 'package:flutter/material.dart';

//-----------------------------------//
//book api:
//    https://www.googleapis.com/books/v1/volumes?q=denemece
//    AIzaSyB1K2m2P6r_jDHjAXX_mZ6bS1pYrMXlXCc
//----------------------------------//
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
    SizeConfig().init(context);
    return Scaffold(
      //backgroundColor: Colors.lightBlueAccent.shade100,
      body: OptionsPage(),
    );
  }
}

/*
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
    SizeConfig().init(context);
    return Scaffold(
      //backgroundColor: Colors.lightBlueAccent.shade100,
      body: MasterPage(),
    );
  }
}
*/
