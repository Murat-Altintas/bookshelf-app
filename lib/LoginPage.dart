import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grade_point_avarage/MasterPage.dart';
import 'package:grade_point_avarage/View/TextFields.dart';
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
                            height: heightSize(30),
                            child: Image.asset("assets/images/loginPage.png"),
                          ),
                          SizedBox(
                            height: heightSize(3),
                          ),
                          TextFields(
                            obscureText: false,
                            controller: mailText,
                            hintText: "USERNAME",
                            textStyle: textfieldStyle,
                            validator: (String mailControl) {
                              TextFields.mailControl(mailControl);
                            },
                          ),
                          SizedBox(
                            height: heightSize(3),
                          ),
                          TextFields(
                            obscureText: obscureText,
                            suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: _showPassword),
                            controller: passwordText,
                            hintText: "PASSWORD",
                            textStyle: textfieldStyle,
                            validator: (String passwordControl) {
                              TextFields.passwordControl(passwordControl);
                            },
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
                            textStyle: loginLittle,
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

  Widget loginButton() => InkWell(
        onTap: () {
          if (formKey.currentState.validate()) {
            setState(() {
              debugPrint("formkey çalıştı");

            });
          } else {
            debugPrint("çalışmadı");

            /*
            FirebaseAuth _auth;
            _auth.signInWithEmailAndPassword(
                email: mailText.toString(), password: passwordText.toString());
           */
          }


          /*
              UserRepository().signIn(mailText.toString(), passwordText.toString()).then(
                    (value) =>
                        Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MasterPage())));

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
