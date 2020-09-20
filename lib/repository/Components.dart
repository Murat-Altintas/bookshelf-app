import 'package:flutter/material.dart';
import 'package:MobileBookshelf/init/theme/BlueTheme.dart';
import 'package:MobileBookshelf/View/ContextExtension.dart';

import '../LoginPage.dart';

class Components extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  Future<void> alertDialog(BuildContext context, headline) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(headline),
            titleTextStyle: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
            actions: [
              FlatButton(
                child: Text(
                  "OK",
                  style: blueTheme.textTheme.headline1.copyWith(fontSize: context.normalText),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ],
          );
        });
  }
}
