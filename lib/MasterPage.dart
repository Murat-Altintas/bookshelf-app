import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grade_point_avarage/BookshelfPage2.dart';
import 'package:grade_point_avarage/init/theme/BlueTheme.dart';
import 'ResaultPage.dart';
import 'package:grade_point_avarage/View/ContextExtension.dart';

class MasterPage extends StatefulWidget {
  @override
  MasterPageState createState() => MasterPageState();
}

class MasterPageState extends State<MasterPage> {
  @override
  Widget build(BuildContext context) {
    var welcome = RichText(
      text: TextSpan(
        text: "Welcome",
        style: blueTheme.textTheme.headline5.copyWith(fontSize: context.lowText),
        children: <TextSpan>[
          TextSpan(
            text: ' to your bookshelf...',
            style: blueTheme.textTheme.headline6.copyWith(fontSize: context.lowText),
          ),
        ],
      ),
    );
    var user = RichText(
      text: TextSpan(
        text: "Hello",
        style: blueTheme.textTheme.headline5.copyWith(fontSize: context.normalText),
        children: <TextSpan>[
          TextSpan(
            text: ' Mr. Altintas',
            style: blueTheme.textTheme.headline6.copyWith(fontSize: context.normalText),
          )
        ],
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                padding: context.paddingLow,
                height: context.height * 35,
                child: Image.asset("assets/images/topsearch.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: context.lowestContainer,
                  ),
                  Row(
                    children: <Widget>[
                      welcome,
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      user,
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.lowestContainer,
            ),
            Container(
              padding: EdgeInsets.all(21),
              width: double.infinity,
              height: context.height * 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*
  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ResaultPage()));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        color: Colors.lightBlueAccent,
                        width: context.width * 45,
                        height: context.height * 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              height: context.height * 20,
                              child: Image.asset("assets/images/my_search.png"),
                            ),
                            Text(
                              "MY SEARCH",
                              style: blueTheme.textTheme.headline3.copyWith(fontSize: context.normalText),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
   */
}
