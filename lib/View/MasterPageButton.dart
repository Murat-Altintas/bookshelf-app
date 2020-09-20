import 'package:flutter/material.dart';
import 'package:MobileBookshelf/View/ContextExtension.dart';
import 'package:MobileBookshelf/init/theme/BlueTheme.dart';

class MasterPageButton extends StatefulWidget {
  final onTap;
  final image;
  final text;
  final color;

  const MasterPageButton(
      {Key key, this.onTap, this.image, this.text, this.color})
      : super(key: key);

  @override
  _MasterPageButtonState createState() => _MasterPageButtonState();
}

class _MasterPageButtonState extends State<MasterPageButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          color: widget.color,
          width: context.width * 45,
          height: context.height * 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: context.height * 20,
                child: widget.image,
              ),
              Text(
                widget.text,
                style: blueTheme.textTheme.headline3
                    .copyWith(fontSize: context.heightText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
