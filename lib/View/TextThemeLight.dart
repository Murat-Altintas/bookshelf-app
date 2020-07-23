import 'package:grade_point_avarage/View/ContextExtension.dart';
import 'package:flutter/material.dart';

import 'BaseState.dart';

class Base extends StatefulWidget {
  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends BaseState<Base> {
   TextStyle headline1 = TextStyle(fontSize: 40, fontWeight: FontWeight.w300, letterSpacing: -1.5);
   TextStyle headline2 = TextStyle(fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5);
   TextStyle headline3 = TextStyle(fontSize: 48, fontWeight: FontWeight.w400);
   TextStyle headline4 = TextStyle(fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25);
   TextStyle headline5 = TextStyle(fontSize: 24, fontWeight: FontWeight.w400);
   TextStyle overline = TextStyle(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}