import 'package:flutter/material.dart';
import 'package:grade_point_avarage/LoginPage.dart';
import 'package:grade_point_avarage/style.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'MasterPage.dart';
import 'View/TextFields.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

var mailText = TextEditingController();
var passwordText = TextEditingController();
var _formKey = GlobalKey<FormState>();
bool autoControl = false;

class _CreateAccountState extends State<CreateAccount> {
  double heightSize(double value) {
    value /= 100;
    return MediaQuery.of(context).size.height * value;
  }

  double widthSize(double value) {
    value /= 100;
    return MediaQuery.of(context).size.width * value;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _createAccount() async {
    var firebaseUser = await _auth.createUserWithEmailAndPassword(email: mailText.text, password: passwordText.text).then(
          (value) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          ),
        );
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
                          height: heightSize(40),
                          child: Image.asset("assets/images/createAccount.png"),
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
                          validator: (String passValidator) {
                            if (passValidator != null) {
                              return "Şirenizi yanlış girdiniz!";
                            } else
                              return null;
                          },
                        ),
                        SizedBox(
                          height: heightSize(5),
                        ),
                        createButtonLittle(),
                        SizedBox(
                          height: heightSize(2),
                        ),
                        goToLoginPageLittle(),
                        SizedBox(
                          height: heightSize(5),
                        ),
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
                          child: Image.asset("assets/images/createAccount.png"),
                        ),
                        SizedBox(
                          height: heightSize(3),
                        ),
                        TextFields(
                          controller: mailText,
                          hintText: "USERNAME",
                          textStyle: textfieldStyle,
                          validator: (String mailVali) {
                            if (mailVali != null) {
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
                        goToLoginPage(),
                        SizedBox(
                          height: heightSize(2),
                        ),
                        createButton(),
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

  Widget createButton() => InkWell(
        onTap: () {
          _createAccount();
          /*
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MasterPage()));
     */
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
              "CREATE ACCOUNT",
              style: login,
            ),
          ),
        ),
      );

  Widget createButtonLittle() => InkWell(
        onTap: () {
          _createAccount();
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
              "CREATE ACCOUNT",
              style: loginLittle,
            ),
          ),
        ),
      );

  Widget goToLoginPage() => InkWell(
        onTap: () {
          Navigator.pop(context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(60)),
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

  Widget goToLoginPageLittle() => InkWell(
        onTap: () {
          Navigator.pop(context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(60)),
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
}
