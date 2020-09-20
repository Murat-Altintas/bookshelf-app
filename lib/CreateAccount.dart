import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MobileBookshelf/LoginPage.dart';
import 'package:MobileBookshelf/View/BlueButtons.dart';
import 'package:MobileBookshelf/View/ContextExtension.dart';
import 'package:MobileBookshelf/repository/Components.dart';
import 'package:MobileBookshelf/repository/UserRepository.dart';

import 'View/TextFields.dart';
import 'View/Images/CoffeeImage.dart';
import 'init/theme/BlueTheme.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

var nickNameText = TextEditingController();
var mailText = TextEditingController();
var passwordText = TextEditingController();
var _formKeyCreteAccount = GlobalKey<FormState>();
bool autoControl = false;
bool obscureText = true;
FocusNode _passwordFocus;

class _CreateAccountState extends State<CreateAccount> {
  @override
  void initState() {
    super.initState();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKeyCreteAccount,
        autovalidate: autoControl,
        child: SafeArea(
          child: Padding(
            padding: context.paddingMedium,
            child: ListView(
              children: [
                Container(
                  height: context.height * 35,
                  child: Image.asset("assets/images/createAccount.png"),
                ),
                SizedBox(
                  height: context.lowestContainer,
                ),
                TextFields(
                  validator: UserRepository().nickControl,
                  obscureText: false,
                  controller: nickNameText,
                  hintText: "NICKNAME",
                  textStyle: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
                ),
                SizedBox(
                  height: context.fieldSpaceContainer,
                ),
                TextFields(
                  obscureText: false,
                  controller: mailText,
                  hintText: "E-MAIL",
                  textStyle: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
                  validator: UserRepository().mailControl,
                ),
                SizedBox(
                  height: context.fieldSpaceContainer,
                ),
                TextFields(
                  keyboardType: TextInputType.number,
                  suffixIcon: IconButton(
                      icon: Icon(Icons.remove_red_eye),
                      onPressed: () {
                        setState(() {
                          _showPassword();
                          _passwordFocus.unfocus();
                        });
                      }),
                  controller: passwordText,
                  hintText: "PASSWORD",
                  obscureText: obscureText,
                  textStyle: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
                  validator: UserRepository().passwordControl,
                ),
                SizedBox(
                  height: context.fieldSpaceContainer,
                ),
                BlueButtons(
                  onTap: () async {
                    if (_formKeyCreteAccount.currentState.validate()) {
                      await UserRepository().createUser(mailText.text, passwordText.text, nickNameText.text).then((value) {
                        Components().alertDialog(context, "Please verify your email");
                      });
                    }
                  },
                  incomingText: "CREATE ACCOUNT",
                ),
                SizedBox(
                  height: context.lowestContainer,
                ),
                BlueButtons(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  incomingText: "LOGIN",
                ),
                SizedBox(
                  height: context.lowestContainer,
                ),
                CoffeeImage(
                  double: context.height * 12,
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

  void _showPassword() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  Future<void> _alertDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Please verify your email"),
            titleTextStyle: blueTheme.textTheme.headline1.copyWith(fontSize: context.normalText),
            actions: [
              FlatButton(
                child: Text(
                  "OK",
                  style: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  print("complate");
                },
              ),
            ],
          );
        });
  }
}
