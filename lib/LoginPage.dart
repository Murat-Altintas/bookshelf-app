import 'package:flutter/material.dart';
import 'package:grade_point_avarage/style.dart';
import 'MasterPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

var mailText = TextEditingController();
var passwordText = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  var userNameField = Container(
    width: 300,
    height: 40,
    child: TextField(
      controller: mailText,
      textInputAction: TextInputAction.next,
      textAlign: TextAlign.center,
      autofocus: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(3),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(60)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(60.0)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        hintText: "USERNAME",
        hintStyle: username,
      ),
    ),
  );
  var passwordField = Container(
    width: 300,
    height: 40,
    child: TextField(
      controller: passwordText,
      textInputAction: TextInputAction.go,
      keyboardType: TextInputType.number,
      obscureText: true,
      textAlign: TextAlign.center,
      autofocus: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 3),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(60)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(60.0)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        hintText: "PASSWORD",
        hintStyle: username,
      ),
    ),
  );

  Widget loginButton() => InkWell(
    onTap: () {
      //_loginOptions;
    },
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(60)),
      child: Container(
        alignment: Alignment.center,
        color: mainBlue,
        height: 40,
        width: 150,
        child: Text(
          "LOGIN",
          style: login,
        ),
      ),
    ),
  );

  double heightSize(double value) {
    value /= 100;
    return MediaQuery
        .of(context)
        .size
        .height * value;
  }

  double widthSize(double value) {
    value /= 100;
    return MediaQuery
        .of(context)
        .size
        .width * value;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _loginOptions() async {
    var firebaseUser = await _auth
        .createUserWithEmailAndPassword(
        email: mailText.text, password: passwordText.text)
        .catchError((e) => debugPrint("hata:" + e.toString()));

    if (firebaseUser != null) {
      debugPrint(
          "Uid ${firebaseUser.user.uid} mail : ${firebaseUser.user.email}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        left: widthSize(5),
        right: widthSize(5),
        top: heightSize(8),
        child: Image.asset("assets/images/loginPage.png"),
      ),
      Positioned(
        bottom: heightSize(13),
        left: widthSize(0),
        right: widthSize(0),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Text(
                "WELCOME!",
                style: title,
              ),
              SizedBox(
                height: heightSize(4),
              ),
              userNameField,
              SizedBox(
                height: heightSize(2),
              ),
              passwordField,
              SizedBox(
                height: heightSize(2),
              ),
              Text(
                "Forgot Password?",
                style: TextStyle(
                  fontSize: heightSize(2.5),
                  fontFamily: 'MainFont',
                  color: mainBlue,
                ),
              ),
              SizedBox(
                height: heightSize(4),
              ),
              loginButton(),
              SizedBox(
                height: heightSize(2),
              ),
              Text(
                "CREATE ACCOUNT",
                style: TextStyle(
                  fontSize: heightSize(2.5),
                  fontFamily: 'MainFont',
                  color: mainBlue,
                ),
              ),
            ],
          ),
        ),
      ),
      SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 4, bottom: 8),
          child: Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                "assets/images/loginCoffee.png",
                width: widthSize(30),
                height: widthSize(30),
              )),
        ),
      ),
    ]);
  }
}