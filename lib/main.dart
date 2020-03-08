import 'package:grade_point_avarage/masterpage.dart';

import 'ResaultPage.dart';
import 'loginpage.dart';
import 'loginpage2.dart';
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
      //backgroundColor: Colors.lightBlueAccent.shade100,
      body: MasterPage(),
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
