import 'package:flutter/material.dart';
import 'package:grade_point_avarage/MasterPage.dart';
import 'package:grade_point_avarage/View/LoginButton.dart';
import 'package:grade_point_avarage/View/TextFields.dart';
import 'package:grade_point_avarage/repository/UserRepository.dart';
import 'package:grade_point_avarage/style.dart';
import 'View/CreateAccountButton.dart';

class LoginPage extends StatefulWidget {
  final formKey;
  final bool autoControl;

  const LoginPage({Key key, this.formKey, this.autoControl}) : super(key: key);

  get widget => formKey;

  @override
  _LoginPageState createState() => _LoginPageState();
}

var mailText = TextEditingController();
var passwordText = TextEditingController();
var _formKey = GlobalKey<FormState>();
bool obscureText = true;

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
                          obscureText: false,
                          controller: mailText,
                          hintText: "USERNAME",
                          textStyle: textfieldStyle,
                          validator: (String mailValidator) {
                            if (mailValidator == null) {
                              return "Mail adresinizi yanlış girdiniz!";
                            } else
                              return null;
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
                          validator: (String passwordValidator) {
                            if (passwordValidator == null) {
                              return "Şirenizi yanlış girdiniz!";
                            } else
                              return null;
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
                        TextFields(
                          obscureText: false,
                          controller: mailText,
                          hintText: "USERNAME",
                          textStyle: textfieldStyle,
                          validator: (String mailValidator) {
                            if (mailValidator == null) {
                              return "Mail adresinizi yanlış girdiniz";
                            } else
                              return null;
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
                        SizedBox(
                          height: heightSize(5),
                        ),
                        loginButtonLittle(),
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
          if (_formKey.currentState.validate()) {
            autoControl = true;
          } else {
            UserRepository()
                .signIn(mailText.toString(), passwordText.toString())
                .then((value) => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MasterPage())));
          }
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
      if (!_formKey.currentState.validate()) {
        autoControl = true;
      } else {
        UserRepository()
            .signIn(mailText.toString(), passwordText.toString())
            .then((value) => Navigator.push(context,
            MaterialPageRoute(builder: (context) => MasterPage())));
      }
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
