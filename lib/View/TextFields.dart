import 'package:flutter/material.dart';
import 'package:grade_point_avarage/View/ContextExtension.dart';
import '../style.dart';
import 'BaseState.dart';

class TextFields extends StatefulWidget {

  final testText;

  const TextFields({Key key, this.testText}) : super(key: key);

  @override
  _TextFieldsState createState() => _TextFieldsState();
}

class _TextFieldsState extends BaseState<TextFields> {
  var mailText = TextEditingController();
  var passwordText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle headline2 = TextStyle(fontSize: dynamicHeight(29), fontWeight: FontWeight.w300, letterSpacing: -0.5, color: Colors.green);
    return Text(
      widget.testText,
      style: headline2,
    );
  }
}
