import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grade_point_avarage/FavoritesPage.dart';
import 'package:grade_point_avarage/View/Images/CoffeeImage.dart';
import 'package:grade_point_avarage/View/MasterPageButton.dart';
import 'package:grade_point_avarage/init/theme/BlueTheme.dart';
import 'package:grade_point_avarage/repository/UserRepository.dart';
import 'BookshelfPage.dart';
import 'OptionsPage.dart';
import 'ResaultPage.dart';
import 'package:grade_point_avarage/View/ContextExtension.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MasterPage extends StatefulWidget {


  const MasterPage({Key key}) : super(key: key);

  @override
  MasterPageState createState() => MasterPageState();
}

class MasterPageState extends State<MasterPage> {
  final String userName= UserRepository().userName;
  @override
  Widget build(BuildContext context) {
    Widget welcome = RichText(
      text: TextSpan(
        text: "Welcome",
        style: blueTheme.textTheme.headline5.copyWith(fontSize: context.heightText),
        children: <TextSpan>[
          TextSpan(
            text: ' to your bookshelf...',
            style: blueTheme.textTheme.headline6.copyWith(fontSize: context.normalText),
          ),
        ],
      ),
    );
    Widget user = RichText(
      text: TextSpan(
        text: "Hello ",
        style: blueTheme.textTheme.headline5.copyWith(fontSize: context.heightText),
        children: <TextSpan>[
          TextSpan(
            text: userName,
            style: blueTheme.textTheme.headline6.copyWith(fontSize: context.normalText),
          )
        ],
      ),
    );
    Widget topText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            welcome,
          ],
        ),
        SizedBox(
          height: context.fieldSpaceContainer,
        ),
        Row(
          children: <Widget>[
            user,
          ],
        ),
      ],
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: context.paddingMedium,
          child: Column(
            children: [
              Container(
                height: context.height * 35,
                child: Image.asset("assets/images/topsearch.png"),
              ),
              SizedBox(
                height: context.lowContainer,
              ),
              Padding(
                padding: context.paddingLow,
                child: topText,
              ),
              SizedBox(
                height: context.lowContainer,
              ),
              Container(
                height: context.height * 32,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    MasterPageButton(
                      image: Image.asset("assets/images/my_search.png"),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ResaultPage()));
                      },
                      color: Colors.lightBlue,
                      text: ("My Search"),
                    ),
                    SizedBox(
                      width: context.lowestContainer,
                    ),
                    MasterPageButton(
                      image: Image.asset("assets/images/my_bookshelf.png"),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BookshelfPage()));
                      },
                      color: Colors.deepPurple,
                      text: ("My Bookshelf"),
                    ),
                    SizedBox(
                      width: context.lowestContainer,
                    ),
                    MasterPageButton(
                      image: Image.asset("assets/images/my_favorites.png"),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesPage()));
                      },
                      color: Colors.purple,
                      text: ("My Favorites"),
                    ),
                    SizedBox(
                      width: context.lowestContainer,
                    ),
                    MasterPageButton(
                      image: Image.asset("assets/images/my_options.png"),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OptionsPage()));
                      },
                      color: Colors.pink,
                      text: ("My Options"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: context.lowContainer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
