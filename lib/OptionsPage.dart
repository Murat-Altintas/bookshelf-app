import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  var emailText = TextEditingController();
  var passwordText = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    showSnackBar() {
      final snackBar = SnackBar(
        content: Text("Nickname is changed."),
        duration: Duration(seconds: 4),
        backgroundColor: Colors.yellow,
      );
      scaffoldKey.currentState.showSnackBar(snackBar);
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
      key: scaffoldKey,
      body: Form(
        key: formKey,
        child: SafeArea(
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
                  hintText: "Write your new nickname...",
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.navigate_next,
                      color: blueTheme.primaryColor,
                      size: context.iconSmall,
                    ),
                    onPressed: () {
                      if (formKey.currentState.validate())
                      UserRepository().updateNickname(nickNameText.text);
                      showSnackBar();
                      nickNameText.clear();
                    },
                  ),
                  textStyle: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
                ),
                SizedBox(
                  height: context.lowestContainer,
                ),
                TextFields(
                  validator: UserRepository().mailControl,
                  obscureText: false,
                  controller: emailText,
                  hintText: "Write your new email...",
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.navigate_next,
                      color: blueTheme.primaryColor,
                      size: context.iconSmall,
                    ),
                    onPressed: () {
                      UserRepository().updateMailAndPassword(emailText.text);
                      emailText.clear();
                    },
                  ),
                  textStyle: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
                ),
                SizedBox(
                  height: context.lowestContainer,
                ),
                TextFields(
                  validator: UserRepository().passwordControl,
                  obscureText: false,
                  controller: passwordText,
                  hintText: "Write your new password...",
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.navigate_next,
                      color: blueTheme.primaryColor,
                      size: context.iconSmall,
                    ),
                    onPressed: () {
                      UserRepository().updatePassword(passwordText.text);
                      passwordText.clear();
                    },
                  ),
                  textStyle: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
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
      ),
    );
  }
}
