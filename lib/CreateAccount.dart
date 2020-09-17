import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grade_point_avarage/LoginPage.dart';
import 'package:grade_point_avarage/View/BlueButtons.dart';
import 'package:grade_point_avarage/View/ContextExtension.dart';
import 'package:grade_point_avarage/repository/UserRepository.dart';
import 'MasterPage.dart';
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
      body: Form(
        key: _formKeyCreteAccount,
        autovalidate: autoControl,
        child: SafeArea(
          child: Padding(
            padding: context.paddingMedium,
            child: Column(
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
                        _showPassword();
                        setState(() {
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
                        print("user olustu");
                        _alertDialog(context);
                      });
                    }
                  },
                  incomingText: "CREATE ACCOUNT",
                ),
                SizedBox(
                  height: context.lowestContainer,
                ),
                BlueButtons(
                  onTap: () {},
                  incomingText: "LOGIN",
                ),
                SizedBox(
                  height: context.fieldSpaceContainer,
                ),
                CoffeeImage(
                  double: context.height * 15,
                ),
                SizedBox(
                  height: context.fieldSpaceContainer,
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
