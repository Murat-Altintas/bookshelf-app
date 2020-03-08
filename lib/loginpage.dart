import 'package:flutter/material.dart';
import 'package:grade_point_avarage/style.dart';
import 'masterpage.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  var userNameField = Container(
    width: 300,
    height: 40,
    child: TextField(
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
        hintText: "UserName2",
        hintStyle: username,
      ),
    ),
  );
  var passwordField = Container(
    width: 300,
    height: 40,
    child: TextField(
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MasterPage()));
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(
              child: Image.asset("assets/images/splash.png"),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "WELCOME!",
              style: title,
            ),
            SizedBox(
              height: 5,
            ),
            userNameField,
            SizedBox(
              height: 10,
            ),
            passwordField,
            SizedBox(
              height: 5,
            ),
            Text(
              "Forgot Password?",
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'MainFont',
                color: mainBlue,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            loginButton(),
            SizedBox(
              height: 5,
            ),
            Text(
              "CREATE ACCOUNT",
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'MainFont',
                color: mainBlue,
              ),
            ),
          ],
        ),
        Container(
          alignment: Alignment.bottomLeft,
          child: SizedBox(
            height: 50,
            child: Image.asset("assets/images/coffee.png"),
          ),
        ),
      ],
    );
  }
}
