import 'package:flutter/material.dart';
import 'package:grade_point_avarage/LoginPage.dart';
import 'package:grade_point_avarage/style.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'MasterPage.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

var mailText = TextEditingController();
var passwordText = TextEditingController();
var _formKey = GlobalKey<FormState>();

class _CreateAccountState extends State<CreateAccount> {
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

  Widget createAccount() => InkWell(
    onTap: () {
      Navigator.pop(context,
          MaterialPageRoute(builder: (context) => LoginPage()));
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

    if (firebaseUser != null) {
      debugPrint("Uid ${firebaseUser.user.uid} mail : ${firebaseUser.user.email}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  child: Image.asset("assets/images/createAccount.png"),
                ),
                SizedBox(
                  height: heightSize(3),
                ),
                userNameField(),
                passwordField(),
                SizedBox(
                  height: heightSize(5),
                ),
                createButton(),
                SizedBox(
                  height: heightSize(5),
                ),
                createAccount(),
                Expanded(
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        "assets/images/loginCoffee.png",
                        width: widthSize(30),
                      )),
                ),
                SizedBox(
                  height: heightSize(2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget userNameField() => Container(
        height: heightSize(7),
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

  Widget passwordField() => Container(
        height: heightSize(7),
        child: TextField(
          controller: passwordText,
          textInputAction: TextInputAction.go,
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
}
