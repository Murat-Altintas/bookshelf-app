import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grade_point_avarage/View/BlueButtons.dart';
import 'package:grade_point_avarage/View/Images/CoffeeImage.dart';
import 'package:grade_point_avarage/View/TextFields.dart';
import 'package:grade_point_avarage/init/theme/BlueTheme.dart';
import 'package:grade_point_avarage/View/ContextExtension.dart';
import 'package:grade_point_avarage/repository/UserRepository.dart';
import 'MasterPage.dart';

class OptionsPage extends StatefulWidget {
  @override
  _OptionsPageState createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  var nickNameText = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    _showSnackBar() {
      final snackBar = SnackBar(
        content: Text("Nickname is changed."),
        duration: Duration(seconds: 3),
        backgroundColor: blueTheme.primaryColor,
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }

    Widget headline = RichText(
      text: TextSpan(
        text: "Change",
        style: blueTheme.textTheme.headline5.copyWith(fontSize: context.normalText),
        children: <TextSpan>[
          TextSpan(
            text: ' your account options...',
            style: blueTheme.textTheme.headline6.copyWith(fontSize: context.normalText),
          ),
        ],
      ),
    );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: context.paddingMedium,
          child: Column(
            children: <Widget>[
              SizedBox(
                width: context.width * 90,
                child: Image.asset("assets/images/optionsPage.png"),
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    padding: EdgeInsets.only(right: context.width * 5),
                    iconSize: context.iconSmall,
                    color: Colors.purple,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MasterPage()));
                    },
                  ),
                  headline,
                ],
              ),
              SizedBox(
                height: context.lowContainer,
              ),
              TextFields(
                validator: UserRepository().nameControl,
                obscureText: false,
                controller: nickNameText,
                hintText: "Write your new nickname...",
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.navigate_next,
                    color: blueTheme.primaryColor,
                    size: context.iconSmall,
                  ),
                  onPressed: () {
                    UserRepository().updateNickname(nickNameText.text);
                    nickNameText.clear();
                  },
                ),
                textStyle: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
              ),
              SizedBox(
                height: context.lowestContainer,
              ),
              BlueButtons(
                incomingText: "Change Email",
                onTap: () {},
              ),
              SizedBox(
                height: context.lowestContainer,
              ),
              BlueButtons(
                incomingText: "Change Password",
                onTap: () {},
              ),
              CoffeeImage(
                double: context.height * 20,
              ),
              SizedBox(
                height: context.lowestContainer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
