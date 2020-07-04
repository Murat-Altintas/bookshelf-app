import 'package:flutter/material.dart';

import '../style.dart';

class TextFields extends StatefulWidget {
  final controller;
  final validator;

  const TextFields({Key key, this.controller, this.validator}) : super(key: key);

  @override
  _TextFieldsState createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  var mailText = TextEditingController();
  var passwordText = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      //height: heightSize(10),
      child: TextFormField(
        validator: (String mailValidator) {
          if (mailValidator != null) {
            return "Mail adresinizi yanlış girdiniz";
          } else
            return null;
        },
        controller: mailText,
        textInputAction: TextInputAction.next,
        textAlign: TextAlign.center,
        autofocus: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(3),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(60)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(60.0)),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          hintStyle: username,
        ),
      ),
    );
  }
}
