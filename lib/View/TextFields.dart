import 'package:flutter/material.dart';

import '../style.dart';

class TextFields extends StatefulWidget {
  final controller;
  final validator;
  final String hintText;
  final textStyle;
  final suffixIcon;
  final obscureText;
  final error;

  const TextFields({Key key, this.controller, this.validator, this.hintText, this.textStyle, this.suffixIcon, this.obscureText, this.error}) : super(key: key);


  static String mailControl(String value) {
    String regEx =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(regEx);
    if (value.length == 0) {
      return "Email adresi gerekli";
    } else if (!regExp.hasMatch(value)) {
      return "Geçersiz mail adresi";
    } else {
      return null;
    }
  }

  static String passwordControl(String value) {
    if (value.isEmpty) {
      return "Şifre alanını boş bırakmayınız.";
    } else if (value.length <= 4 && value.length <= 20) {
      return "Şifre 5-20 karakter arasında olmalıdır";
    } else {
      return null;
    }
  }


  @override
  _TextFieldsState createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText,
      validator: widget.validator,
      controller: widget.controller,
      textInputAction: TextInputAction.next,
      textAlign: TextAlign.center,
      autofocus: false,
      decoration: InputDecoration(

        suffixIcon: widget.suffixIcon,
        errorText: widget.error,
        contentPadding: EdgeInsets.all(3),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(60)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(60.0)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        hintStyle: widget.textStyle,
        hintText: widget.hintText,
      )
       ,
    );

  }


}
