import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grade_point_avarage/CreateAccount.dart';
import 'package:grade_point_avarage/View/TextFields.dart';
import 'package:grade_point_avarage/style.dart';

import 'MasterPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

var mailText = TextEditingController();
var passwordText = TextEditingController();
var _formKey = GlobalKey<FormState>();

class _LoginPageState extends State<LoginPage> {
  bool autoControl = false;

  double heightSize(double value) {
    value /= 100;
    return MediaQuery.of(context).size.height * value;
  }

  double widthSize(double value) {
    value /= 100;
    return MediaQuery.of(context).size.width * value;
  }

  void _loginAccount() async {
    final _auth = FirebaseAuth.instance;
    if (_formKey.currentState.validate()) {
      autoControl = true;
    } else {
      var firebaseUser = await _auth
          .signInWithEmailAndPassword(
              email: mailText.text, password: passwordText.text)
          .then((value) => Navigator.push(
              context, MaterialPageRoute(builder: (context) => MasterPage())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _formKey,
        autovalidate: autoControl,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: LayoutBuilder(builder: (context, constraints) {
              return constraints.maxWidth < 400
                  ? Column(
                      children: [
                        Container(
                          height: heightSize(30),
                          child: Image.asset("assets/images/loginPage.png"),
                        ),
                        SizedBox(
                          height: heightSize(3),
                        ),
                        TextFields(
                          controller: mailText,
                          hintText: "USERNAME",
                          textStyle: textfieldStyle,
                          validator: (String mailValidator) {
                            if (mailValidator != null) {
                              return "Mail adresinizi yanlış girdiniz!";
                            } else
                              return null;
                          },
                        ),
                        SizedBox(
                          height: heightSize(3),
                        ),
                        TextFields(
                          controller: passwordText,
                          hintText: "PASSWORD",
                          textStyle: textfieldStyle,
                          validator: (String passwordValidator) {
                            if (passwordValidator != null) {
                              return "Şirenizi yanlış girdiniz!";
                            } else
                              return null;
                          },
                        ),
                        SizedBox(
                          height: heightSize(5),
                        ),
                        loginButtonLittle(),
                        SizedBox(
                          height: heightSize(5),
                        ),
                        createAccountLittle(),
                        coffeeImageLittle(),
                        SizedBox(
                          height: heightSize(2),
                        ),
                      ],
                    )
                  : Column(
                      children: <Widget>[
                        Container(
                          height: heightSize(30),
                          child: Image.asset("assets/images/loginPage.png"),
                        ),
                        SizedBox(
                          height: heightSize(3),
                        ),
                        TextFields(
                          controller: mailText,
                          hintText: "USERNAME",
                          textStyle: textfieldStyle,
                          validator: (String mailValidator) {
                            if (mailValidator != null) {
                              return "Mail adresinizi yanlış girdiniz";
                            } else
                              return null;
                          },
                        ),
                        SizedBox(
                          height: heightSize(5),
                        ),
                        TextFields(
                          controller: mailText,
                          hintText: "PASSWORD",
                          textStyle: textfieldStyle,
                          validator: (String passwordValidator) {
                            if (passwordValidator != null) {
                              return "Şirenizi yanlış girdiniz";
                            } else
                              return null;
                          },
                        ),
                        SizedBox(
                          height: heightSize(5),
                        ),
                        loginButtonLittle(),
                        SizedBox(
                          height: heightSize(5),
                        ),
                        createAccount(),
                        coffeeImage(),
                        SizedBox(height: heightSize(2)),
                      ],
                    );
            }),
          ),
        ),
      ),
    );
  }

  Widget coffeeImage() => Expanded(
        child: Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              "assets/images/loginCoffee.png",
              width: widthSize(30),
            )),
      );

  Widget coffeeImageLittle() => Expanded(
        child: Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              "assets/images/loginCoffee.png",
              width: widthSize(25),
            )),
      );

  Widget loginButton() => InkWell(
        onTap: () {
          _loginAccount();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(60),
          ),
          child: Container(
            alignment: Alignment.center,
            color: mainBlue,
            height: heightSize(7),
            child: Text(
              "LOGIN",
              style: login,
            ),
          ),
        ),
      );

  Widget loginButtonLittle() => InkWell(
        onTap: () {
          _loginAccount();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(60),
          ),
          child: Container(
            alignment: Alignment.center,
            color: mainBlue,
            height: heightSize(7),
            child: Text(
              "LOGIN",
              style: loginLittle,
            ),
          ),
        ),
      );

  Widget createAccount() => InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateAccount()));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(60)),
          child: Container(
            alignment: Alignment.center,
            color: mainBlue,
            height: heightSize(7),
            child: Text(
              "CREATE ACCOUNT",
              style: login,
            ),
          ),
        ),
      );

  Widget createAccountLittle() => InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateAccount()));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(60)),
          child: Container(
            alignment: Alignment.center,
            color: mainBlue,
            height: heightSize(7),
            child: Text(
              "CREATE ACCOUNT",
              style: loginLittle,
            ),
          ),
        ),
      );
}
