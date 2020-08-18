import 'package:flutter/material.dart';
import 'package:grade_point_avarage/View/ContextExtension.dart';
import 'package:grade_point_avarage/init/theme/BlueTheme.dart';

class MasterPageButton extends StatefulWidget {
  final OnTap;
  final Image;
  final Text;
  final Color;

  const MasterPageButton({Key key, this.OnTap, this.Image, this.Text, this.Color}) : super(key: key);

  @override
  _MasterPageButtonState createState() => _MasterPageButtonState();
}

class _MasterPageButtonState extends State<MasterPageButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.OnTap,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          color: widget.Color,
          width: context.width * 45,
          height: context.height * 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: context.height * 20,
                child: widget.Image,
              ),
              Text(
                widget.Text,
                style: blueTheme.textTheme.headline3.copyWith(fontSize: context.heightText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
