import 'package:flutter/material.dart';
import 'package:grade_point_avarage/LoginPage.dart';
import 'package:grade_point_avarage/View/BlueButtons.dart';
import 'package:grade_point_avarage/View/ContextExtension.dart';
import 'package:grade_point_avarage/repository/UserRepository.dart';
import 'View/TextFields.dart';
import 'View/Images/CoffeeImage.dart';
import 'init/theme/BlueTheme.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

var mailText = TextEditingController();
var passwordText = TextEditingController();
var _formKey = GlobalKey<FormState>();
bool autoControl = false;
bool obscureText = true;

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _formKey,
        autovalidate: autoControl,
        child: SafeArea(
          child: Padding(
            padding: context.paddingMedium,
            child: LayoutBuilder(builder: (context, constraints) {
              return constraints.maxWidth < 400
                  ? Column(
                      children: [
                        Container(
                          height: context.height * 40,
                          child: Image.asset("assets/images/createAccount.png"),
                        ),
                        SizedBox(
                          height: context.lowestContainer,
                        ),
                        TextFields(
                          obscureText: false,
                          controller: mailText,
                          hintText: "USERNAME",
                          textStyle:
                              blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
                          validator: (String mailValidator) {
                            if (mailValidator != null) {
                              return "Mail adresinizi yanlış girdiniz!";
                            } else
                              return null;
                          },
                        ),
                        SizedBox(
                          height: context.lowestContainer,
                        ),
                        TextFields(
                          suffixIcon: IconButton(
                              icon: Icon(Icons.remove_red_eye), onPressed: _showPassword),
                          controller: passwordText,
                          hintText: "PASSWORD",
                          obscureText: true,
                          textStyle:
                              blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
                          validator: (String passValidator) {
                            if (passValidator != null) {
                              return "Şirenizi yanlış girdiniz!";
                            } else
                              return null;
                          },
                        ),
                        SizedBox(
                          height: context.lowestContainer,
                        ),
                        BlueButtons(
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              UserRepository().createUser(mailText.text, String, passwordText.text);
                            }
                          },
                          incomingText: "CREATE ACCOUNT",
                        ),
                        SizedBox(
                          height: context.lowContainer,
                        ),
                        BlueButtons(
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => LoginPage()));
                          },
                          incomingText: "LOGIN",
                        ),
                        CoffeeImage(
                          double: context.height * 15,
                        ),
                        SizedBox(
                          height: context.height * 2,
                        ),
                      ],
                    )
                  : Column(
                      children: <Widget>[
                        Container(
                          height: context.height * 30,
                          child: Image.asset("assets/images/createAccount.png"),
                        ),
                        SizedBox(
                          height: context.height * 3,
                        ),
                        TextFields(
                          controller: mailText,
                          hintText: "USERNAME",
                          textStyle:
                              blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
                          validator: (String mailVali) {
                            if (mailVali != null) {
                              return "Mail adresinizi yanlış girdiniz!";
                            } else
                              return null;
                          },
                        ),
                        SizedBox(
                          height: context.lowestContainer,
                        ),
                        TextFields(
                          controller: passwordText,
                          hintText: "PASSWORD",
                          suffixIcon: IconButton(
                              icon: Icon(Icons.remove_red_eye), onPressed: _showPassword),
                          textStyle:
                              blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
                          validator: (String passwordValidator) {
                            if (passwordValidator != null) {
                              return "Şirenizi yanlış girdiniz!";
                            } else
                              return null;
                          },
                        ),
                        SizedBox(
                          height: context.lowContainer,
                        ),
                        BlueButtons(
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => LoginPage()));
                          },
                          incomingText: "LOGIN",
                        ),
                        SizedBox(
                          height: context.lowestContainer,
                        ),
                        CoffeeImage(
                          double: context.height * 15,
                        ),
                        SizedBox(
                          height: context.lowestContainer,
                        ),
                      ],
                    );
            }),
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
}
