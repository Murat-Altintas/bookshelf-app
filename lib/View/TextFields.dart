import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grade_point_avarage/View/ContextExtension.dart';
import 'package:grade_point_avarage/init/theme/BlueTheme.dart';

class TextFields extends StatefulWidget {
  final controller;
  final validator;
  final String hintText;
  final textStyle;
  final suffixIcon;
  final obscureText;
  final error;

  const TextFields({Key key, this.controller, this.validator, this.hintText, this.textStyle, this.suffixIcon, this.obscureText, this.error})
      : super(key: key);

  @override
  _TextFieldsState createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.heighContainer,
      child: TextFormField(
        obscureText: widget.obscureText,
        validator: widget.validator,
        controller: widget.controller,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 15, left: 20),
          errorStyle: TextStyle(
            fontSize: context.lowText,
          ),
          suffixIcon: widget.suffixIcon,
          errorText: widget.error,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(context.lowContainer)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(context.lowContainer)),
            borderSide: BorderSide(color: blueTheme.primaryColor, width: 2),
          ),
          errorBorder: blueTheme.inputDecorationTheme.errorBorder,
          hintStyle: widget.textStyle,
          hintText: widget.hintText,
        ),
      ),
    );
  }
}
