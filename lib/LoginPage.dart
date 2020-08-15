import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grade_point_avarage/MasterPage.dart';
import 'package:grade_point_avarage/View/BlueButtons.dart';
import 'CreateAccount.dart';
import 'View/Images/CoffeeImage.dart';
import 'View/ContextExtension.dart';
import 'View/TextFields.dart';
import 'package:grade_point_avarage/repository/UserRepository.dart';
import 'package:provider/provider.dart';
import 'View/CreateAccountButton.dart';
import 'init/theme/BlueTheme.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool autoControl = false;
  var mailText = TextEditingController();
  var passwordText = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserRepository>(
      create: (context) => UserRepository(),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Form(
          key: formKey,
          autovalidate: autoControl,
          child: SafeArea(
            child: Padding(
              padding: context.paddingMedium,
              child: LayoutBuilder(builder: (context, constraints) {
                return constraints.maxWidth < 400
                    ? Column(
                        children: [
                          Container(
                            height: context.height * 30,
                            child: Image.asset("assets/images/loginPage.png"),
                          ),
                          SizedBox(
                            height: context.lowestContainer,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: context.width * 45,
                                child: TextFields(
                                  validator: nameControl,
                                  obscureText: false,
                                  controller: mailText,
                                  hintText: "NAME",
                                  textStyle: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
                                ),
                              ),
                              Container(
                                width: context.width * 45,
                                child: TextFields(
                                  validator: surnameControl,
                                  obscureText: false,
                                  controller: mailText,
                                  hintText: "SURNAME",
                                  textStyle: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: context.lowestContainer,
                          ),
                          TextFields(
                            validator: mailControl,
                            obscureText: false,
                            controller: mailText,
                            hintText: "MAIL",
                            textStyle: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
                          ),
                          SizedBox(
                            height: context.lowestContainer,
                          ),
                          TextFields(
                            validator: passwordControl,
                            obscureText: obscureText,
                            suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye), onPressed: _showPassword),
                            controller: passwordText,
                            hintText: "PASSWORD",
                            textStyle: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
                          ),
                          SizedBox(
                            height: context.lowestContainer,
                          ),
                          BlueButtons(
                            onTap: () {
                              if (formKey.currentState.validate()) {
                                UserRepository()
                                    .signIn(mailText.text, passwordText.text)
                                    .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => MasterPage())));
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
                            height: context.lowestContainer,
                          ),
                          CoffeeImage(
                            double: context.height * 15,
                          ),
                          SizedBox(
                            height: context.height * 1,
                          ),
                        ],
                      )
                    : Column(
                        children: <Widget>[
                          Container(
                            height: context.height * 10,
                            child: Image.asset("assets/images/loginPage.png"),
                          ),
                          SizedBox(
                            height: context.height * 3,
                          ),
                          CreateAccountButton(),
                          CoffeeImage(
                            double: context.height * 15,
                          ),
                          SizedBox(
                            height: context.height * 3,
                          ),
                        ],
                      );
              }),
            ),
          ),
        ),
      ),
    );
  }

  static String nameControl(String value) {
    String regEx =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(regEx);
    if (value.length == 0) {
      return "Please write a name";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid name";
    } else {
      return null;
    }
  }

  static String surnameControl(String value) {
    String regEx =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(regEx);
    if (value.length == 0) {
      return "Please write a surname";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid surname";
    } else {
      return null;
    }
  }

  static String mailControl(String value) {
    String regEx =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(regEx);
    if (value.length == 0) {
      return "Email adresi gerekli";
    } else if (!regExp.hasMatch(value)) {
      return "Geçersiz mail adresi";
    } else {
      return null;
    }
  }

  static String passwordControl(String value) {
    if (value.isEmpty) {
      return "Şifre alanını boş bırakmayınız.";
    } else if (value.length <= 4 && value.length <= 20) {
      return "Şifre 5-20 karakter arasında olmalıdır";
    } else {
      return null;
    }
  }

  void _showPassword() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
