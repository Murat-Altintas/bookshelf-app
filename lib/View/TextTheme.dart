import 'package:flutter/material.dart';
import 'package:grade_point_avarage/View/ContextExtension.dart';
import 'package:grade_point_avarage/style.dart';

class TextTheme {

  static TextTheme _instance;
  static TextTheme get _instace {
    if(_instace == null) _instance = TextTheme.init();
    return _instace;
  }
  TextTheme.init();

}

