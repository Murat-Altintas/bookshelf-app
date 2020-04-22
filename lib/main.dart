import 'package:grade_point_avarage/BookshelfPage.dart';
import 'package:grade_point_avarage/MasterPage.dart';
import 'BookshelfPage2.dart';
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
    SizeConfig2().init(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,

      //backgroundColor: Colors.lightBlueAccent.shade100,
      body: ResaultPage(),
    );
  }
}

/*
FractionallySizedBox(), // widthFactor: 0,7 vermek mevcut child boyutunun %70'i demek.
SizedBox(),
FlexFit(),
Flex(),
Flexible(),
FittedBox(),
Spacer(),
 */