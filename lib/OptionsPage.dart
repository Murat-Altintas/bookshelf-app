import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:MobileBookshelf/View/BlueButtons.dart';
import 'package:MobileBookshelf/View/Images/CoffeeImage.dart';
import 'package:MobileBookshelf/View/TextFields.dart';
import 'package:MobileBookshelf/init/theme/BlueTheme.dart';
import 'package:MobileBookshelf/View/ContextExtension.dart';
import 'package:MobileBookshelf/repository/Components.dart';
import 'package:MobileBookshelf/repository/UserRepository.dart';
import 'LoginPage.dart';
import 'MasterPage.dart';

class OptionsPage extends StatefulWidget {
  @override
  _OptionsPageState createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  var _nickNameText = TextEditingController();
  var _mailText = TextEditingController();
  var _passwordText = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool autoValidate = false;
  FocusNode _fNode;

  @override
  void initState() {
    super.initState();
    _fNode = FocusNode();
  }

  @override
  void dispose() {
    _fNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    showSnackBar(String change) {
      final snackBar = SnackBar(
        content: Text("$change"),
        duration: Duration(seconds: 6),
        backgroundColor: Colors.blue,
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
      resizeToAvoidBottomInset: true,
      key: scaffoldKey,
      body: Form(
        key: formKey,
        autovalidate: true,
        child: SafeArea(
          child: Padding(
            padding: context.paddingMedium,
            child: ListView(
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
                  focusNode: _fNode,
                  controller: _nickNameText,
                  validator: UserRepository().nickControl,
                  obscureText: false,
                  hintText: "Write your new nickname...",
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.navigate_next,
                      color: blueTheme.primaryColor,
                      size: context.iconSmall,
                    ),
                    onPressed: () {
                      if (UserRepository().nickControl(_nickNameText.text) == null) {
                        UserRepository()
                            .updateNickname(_nickNameText.text)
                            .then((value) => showSnackBar(value))
                            .catchError((onError) => showSnackBar(onError));
                        _nickNameText.clear();
                      }
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
                  controller: _mailText,
                  hintText: "Write your new email...",
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.navigate_next,
                      color: blueTheme.primaryColor,
                      size: context.iconSmall,
                    ),
                    onPressed: () {
                      UserRepository().updateMail(_mailText.text);
                      Components().alertDialog(context, "Please verify your new email");
                      setState(() {
                        _fNode.unfocus();
                        _mailText.clear();
                        autoValidate = false;
                      });
                    },
                  ),
                  textStyle: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
                ),
                SizedBox(
                  height: context.lowestContainer,
                ),
                TextFields(
                  validator: UserRepository().passwordControl,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  controller: _passwordText,
                  hintText: "Write your new password...",
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.navigate_next,
                      color: blueTheme.primaryColor,
                      size: context.iconSmall,
                    ),
                    onPressed: () {
                      UserRepository()
                          .updatePassword(_passwordText.text)
                          .then((value) => showSnackBar(value))
                          .catchError((onError) => showSnackBar(onError));
                      _fNode.unfocus();
                      _passwordText.clear();
                      setState(() {
                        autoValidate = false;
                      });
                    },
                  ),
                  textStyle: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _alertDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Please verify your email"),
            titleTextStyle: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
            actions: [
              FlatButton(
                child: Text(
                  "OK",
                  style: blueTheme.textTheme.headline1.copyWith(fontSize: context.normalText),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  print("mail is not verified");
                },
              ),
            ],
          );
        });
  }
}
