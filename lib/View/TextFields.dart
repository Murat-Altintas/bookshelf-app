import 'package:flutter/material.dart';

import '../style.dart';

class TextFields extends StatefulWidget {
  final controller;
  final validator;
  final String hintText;
  final textStyle;
  const TextFields({Key key, this.controller, this.validator, this.hintText, this.textStyle}) : super(key: key);

  @override
  _TextFieldsState createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
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
          hintStyle: widget.textStyle,
          hintText: widget.hintText,
        ),
      ),
    );
  }
}
