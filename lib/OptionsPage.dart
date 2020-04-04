import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MasterPage.dart';

class OptionsPage extends StatefulWidget {
  @override
  _OptionsPageState createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  double heightSize(double value) {
    value /= 100;
    return MediaQuery.of(context).size.height * value;
  }

  double widthSize(double value) {
    value /= 100;
    return MediaQuery.of(context).size.width * value;
  }

  @override
  Widget build(BuildContext context) {
    var welcome = RichText(
      text: TextSpan(
        text: "Change",
        style: TextStyle(
          fontSize: heightSize(3),
          color: Colors.purple,
          fontFamily: 'MainFont',
          fontWeight: FontWeight.w700,
        ),
        children: <TextSpan>[
          TextSpan(
            text: ' your account options...',
            style: TextStyle(
              fontSize: heightSize(3),
              color: Colors.purple,
              fontFamily: 'MainFont',
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: widthSize(90),
              child: Image.asset("assets/images/optionsPage.png"),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(10),
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        iconSize: heightSize(4),
                        color: Colors.purple,
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => MasterPage()));
                        },
                      ),
                      welcome,
                    ],
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Change Name",
                        style: TextStyle(fontSize: heightSize(3.5)),
                      ),
                    ),
                    color: Colors.lightBlue,
                    elevation: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
