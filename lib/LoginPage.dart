import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grade_point_avarage/MasterPage.dart';
import 'View/ContextExtension.dart';
import 'View/TextFields.dart';
import 'package:grade_point_avarage/repository/UserRepository.dart';
import 'package:grade_point_avarage/style.dart';
import 'package:provider/provider.dart';
import 'View/CreateAccountButton.dart';

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

  double heightSize(double value) {
    value /= 100;
    return MediaQuery.of(context).size.height * value;
  }

  double widthSize(double value) {
    value /= 100;
    return MediaQuery.of(context).size.width * value;
  }

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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LayoutBuilder(builder: (context, constraints) {
                return constraints.maxWidth < 400
                    ? Column(
                        children: [
                          Container(
                            height: context.height*.2,
                            child: Image.asset("assets/images/loginPage.png"),
                          ),
                          SizedBox(
                            height: heightSize(3),
                          ),
                          TextFields(
                            validator: mailControl,
                            obscureText: false,
                            controller: mailText,
                            hintText: "MAIL",
                            textStyle: textfieldStyle,
                          ),
                          SizedBox(
                            height: heightSize(3),
                          ),
                          TextFields(
                            validator: passwordControl,
                            obscureText: obscureText,
                            suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye), onPressed: _showPassword),
                            controller: passwordText,
                            hintText: "PASSWORD",
                            textStyle: textfieldStyle,
                          ),
                          SizedBox(
                            height: heightSize(5),
                          ),
                          loginButton(),
                          SizedBox(
                            height: heightSize(5),
                          ),
                          CreateAccountButton(
                            height: heightSize(7),
                            textStyle: login,
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
                            child: Image.asset("assets/images/loginPage.png"),
                          ),
                          SizedBox(
                            height: heightSize(3),
                          ),

                          /*
                          TextFields(
                            obscureText: false,
                            controller: mailText,
                            hintText: "USERNAME",
                            textStyle: textfieldStyle,
                            validator: (String value) {
                              TextFields.mailControl;
                            },
                          ),
                          SizedBox(
                            height: heightSize(5),
                          ),
                          TextFields(
                            obscureText: false,
                            suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: _showPassword),
                            controller: passwordText,
                            hintText: "PASSWORD",
                            textStyle: textfieldStyle,
                            validator: (String passwordValidator) {
                              if (passwordValidator == null) {
                                return "Şirenizi yanlış girdiniz";
                              } else
                                return null;
                            },
                          ),



                           */
                          SizedBox(
                            height: heightSize(5),
                          ),
                          //loginButtonLittle(),
                          SizedBox(
                            height: heightSize(5),
                          ),
                          CreateAccountButton(
                            height: heightSize(7),
                            textStyle: login,
                          ),
                          coffeeImage(),
                          SizedBox(height: heightSize(2)),
                        ],
                      );
              }),
            ),
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

  Widget loginButton() {
    return InkWell(
      onTap: () {
        UserRepository().signIn(mailText.text, passwordText.text).then((value) =>
            Navigator.push(context, MaterialPageRoute(builder: (context) => MasterPage())));

        /*
            FirebaseAuth _auth;
            _auth.signInWithEmailAndPassword(
                email: mailText.toString(), password: passwordText.toString());
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
            "LOGIN",
            style: login,
          ),
        ),
      ),
    );
  }

  Widget loginButtonLittle() => InkWell(
        onTap: () {
          /*
          if (!formKey.currentState.validate()) {
            setState(() {
              autoControl = true;
            });
          } else {
            UserRepository().signIn(mailText.text, passwordText.text).then(
                (value) => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MasterPage())));
          }

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
              "LOGIN",
              style: loginLittle,
            ),
          ),
        ),
      );

  void _showPassword() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
