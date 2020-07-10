import 'package:flutter/material.dart';

import '../style.dart';

class CreateAccountButton extends StatefulWidget {
  final double height;
  final textStyle;

  const CreateAccountButton({Key key, this.height, this.textStyle}) : super(key: key);
  @override
  _CreateAccountButtonState createState() => _CreateAccountButtonState();
}

class _CreateAccountButtonState extends State<CreateAccountButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CreateAccountButton()));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(60)),
        child: Container(
          alignment: Alignment.center,
          color: mainBlue,
          height: widget.height,
          child: Text(
            "CREATE ACCOUNT",
            style: widget.textStyle,
          ),
        ),
      ),
    );
  }
}
