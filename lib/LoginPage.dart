import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:MobileBookshelf/MasterPage.dart';
import 'package:MobileBookshelf/View/BlueButtons.dart';
import 'package:MobileBookshelf/repository/Components.dart';
import 'CreateAccount.dart';
import 'FavoritesPage.dart';
import 'View/Images/CoffeeImage.dart';
import 'View/ContextExtension.dart';
import 'View/TextFields.dart';
import 'package:MobileBookshelf/repository/UserRepository.dart';
import 'init/theme/BlueTheme.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool autoControl = false;
  var formKey = GlobalKey<FormState>();
  bool obscureText = true;
  FocusNode _mailTextFocus;

  @override
  void initState() {
    super.initState();
    _mailTextFocus = FocusNode();
  }

  @override
  void dispose() {
    _mailTextFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: formKey,
        autovalidate: autoControl,
        child: SafeArea(
          child: Padding(
              padding: context.paddingMedium,
              child: Column(
                children: [
                  Container(
                    height: context.height * 30,
                    child: Image.asset("assets/images/loginPage.png"),
                  ),
                  SizedBox(
                    height: context.lowestContainer,
                  ),
                  SizedBox(
                    height: context.fieldSpaceContainer,
                  ),
                  TextFields(
                    focusNode: _mailTextFocus,
                    validator: UserRepository().mailControl,
                    obscureText: false,
                    controller: mailText,
                    hintText: "MAIL",
                    textStyle: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
                  ),
                  SizedBox(
                    height: context.lowestContainer,
                  ),
                  TextFields(
                    keyboardType: TextInputType.number,
                    validator: UserRepository().passwordControl,
                    obscureText: obscureText,
                    suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye), onPressed: _showPassword),
                    controller: passwordText,
                    hintText: "PASSWORD",
                    textStyle: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
                  ),
                  SizedBox(
                    height: context.lowContainer,
                  ),
                  BlueButtons(
                    onTap: () {
                      if (mailText.text != null) {
                        _mailTextFocus.unfocus();
                      }
                      if (formKey.currentState.validate()) {
                        UserRepository().signIn(mailText.text, passwordText.text).then(
                          (value) {
                            if (value.contains("OK")) {
                              UserRepository()
                                  .getNickname()
                                  .then((name) => Navigator.push(context, MaterialPageRoute(builder: (context) => MasterPage())));
                            } else if (!value.contains("OK")) {
                              Components().alertDialog(context, "Please verify your email");
                            }
                          },
                        ).catchError((onError) {
                          Components().alertDialog(context, "Wrong email or password");
                        });
                      }
                    },
                    incomingText: "LOGIN",
                  ),
                  SizedBox(
                    height: context.lowestContainer,
                  ),
                  BlueButtons(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccount()));
                    },
                    incomingText: "CREATE ACCOUNT",
                  ),
                  SizedBox(
                    height: context.lowContainer,
                  ),
                  CoffeeImage(
                    double: context.height * 20
                  ),
                  SizedBox(
                    height: context.height * 1,
                  ),
                ],
              )),
        ),
      ),
    );
  }

  void _showPassword() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  Future<void> _alertDialog(BuildContext context, headline) {
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
