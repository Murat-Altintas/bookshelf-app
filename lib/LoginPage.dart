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
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var firebaseUser = await _auth
        .signInWithEmailAndPassword(
//            email: mailText.text, password: passwordText.text)
            email: 'test@test.com',
            password: '123123')
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (context) => MasterPage())));

//
//    final FirebaseAuth _auth = FirebaseAuth.instance;
//    if(_formKey.currentState.validate()) {
//      autoControl = true;
//    }else {
//      var firebaseUser = await _auth.signInWithEmailAndPassword(email: mailText.text, password: passwordText.text).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => MasterPage())));
//    }
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
                        //userNameFieldLittle(),
                        TextFields(
                          validator: (String mailValidator) {
                            if (mailValidator != null) {
                              return "Mail adresinizi yanlış girdiniz";
                            } else
                              return null;
                          },
                          controller: mailText,
                        ),
                        passwordFieldLittle(),
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
                        userNameField(),
                        SizedBox(
                          height: heightSize(3),
                        ),
                        passwordField(),
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

  Widget userNameField() => Container(
        height: heightSize(10),
        child: TextFormField(
          validator: (String mailValidator) {
            if (mailValidator != null) {
              return "Mail adresinizi yanlış girdiniz";
            } else
              return null;
          },
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

  Widget userNameFieldLittle() => Container(
        height: heightSize(10),
        child: TextFormField(
          validator: (String mailValidator) {
            if (mailValidator != null) {
              return "Mail adresinizi yanlış girdiniz";
            } else
              return null;
          },
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
            hintStyle: usernameLittle,
          ),
        ),
      );

  Widget passwordField() => Container(
        height: heightSize(10),
        child: TextFormField(
          controller: passwordText,
          validator: (String mailValidator) {
            if (mailValidator != null) {
              return "Şifrenizi yanlış girdiniz";
            } else
              return null;
          },
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

  Widget passwordFieldLittle() => Container(
        height: heightSize(10),
        child: TextFormField(
          controller: passwordText,
          validator: (String mailValidator) {
            if (mailValidator != null) {
              return "Şifrenizi yanlış girdiniz";
            } else
              return null;
          },
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
            hintStyle: usernameLittle,
          ),
        ),
      );
}
