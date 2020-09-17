import 'package:flutter/material.dart';
import 'package:grade_point_avarage/init/theme/BlueTheme.dart';
import 'package:grade_point_avarage/View/ContextExtension.dart';

import '../LoginPage.dart';

class Components extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  Future<void> alertDialog(BuildContext context, headText, subText) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(headText),
            titleTextStyle: blueTheme.textTheme.headline1.copyWith(fontSize: context.normalText),
            actions: [
              FlatButton(
                child: Text(
                  subText,
                  style: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
                ),
                onPressed: () {
                },
              ),
            ],
          );
        });
  }
}
