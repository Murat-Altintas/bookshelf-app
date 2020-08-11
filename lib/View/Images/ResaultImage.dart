import 'package:flutter/material.dart';
import 'package:grade_point_avarage/View/ContextExtension.dart';
import 'package:grade_point_avarage/init/theme/BlueTheme.dart';

class ResaultImage extends StatefulWidget {
  @override
  _ResaultImageState createState() => _ResaultImageState();
}

class _ResaultImageState extends State<ResaultImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 28,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: context.height * 6,
            left: context.height * 2,
            child: titleText(),
          ),
          Positioned(
            left: context.width * 46,
            top: context.height * 2,
            child: Container(
                height: context.height * 25, child: Image.asset("assets/images/resaultPage.png")),
          ),
        ],
      ),
    );
  }

  Widget titleText() => RichText(
        text: TextSpan(
          text: "What would \n",
          style: blueTheme.textTheme.headline5.copyWith(fontSize: context.height * 4.5),
          children: <TextSpan>[
            TextSpan(
                text: 'you like to \n',
                style: blueTheme.textTheme.headline5
                    .copyWith(fontSize: context.height * 4.5, height: context.height * 0.2)),
            TextSpan(
                text: 'learn today?',
                style: blueTheme.textTheme.headline5
                    .copyWith(fontSize: context.height * 4.5, height: context.height * 0.2)),
          ],
        ),
      );
}
