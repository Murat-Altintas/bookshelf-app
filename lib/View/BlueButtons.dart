import 'package:flutter/material.dart';
import 'package:grade_point_avarage/init/theme/BlueTheme.dart';
import 'package:grade_point_avarage/View/ContextExtension.dart';

class BlueButtons extends StatefulWidget {
  final onTap;
  final incomingText;

  const BlueButtons({Key key, this.onTap, this.incomingText}) : super(key: key);

  @override
  _BlueButtonsState createState() => _BlueButtonsState();
}

class _BlueButtonsState extends State<BlueButtons> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(context.height * 5)),
          color: blueTheme.primaryColor,
        ),
        alignment: Alignment.center,
        height: context.lowContainer,
        child: Text(
          widget.incomingText,
          style: blueTheme.textTheme.headline3.copyWith(fontSize: context.normalText),
        ),
      ),
    );
  }
}
