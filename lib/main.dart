import 'package:grade_point_avarage/BookRequest.dart';
import 'package:grade_point_avarage/BookshelfPage.dart';
import 'package:grade_point_avarage/MasterPage.dart';
import 'ResaultPage.dart';
import 'LoginPage.dart';
import 'LoginPage.dart';
import 'style.dart';
import 'package:flutter/material.dart';

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
      resizeToAvoidBottomPadding: false,

      //backgroundColor: Colors.lightBlueAccent.shade100,
      body: BookshelfPage(),
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
