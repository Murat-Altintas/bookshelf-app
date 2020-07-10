import 'package:flutter/material.dart';
import 'package:grade_point_avarage/LoginPage.dart';
import 'package:grade_point_avarage/repository/UserRepository.dart';

import '../CreateAccount.dart';
import '../MasterPage.dart';
import '../style.dart';

class LoginButton extends StatefulWidget {
  final double height;
  final textStyle;

  const LoginButton({Key key, this.height, this.textStyle}) : super(key: key);
  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  var mailText = TextEditingController();
  var passwordText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (LoginPage().widget.formKey.currentState.validate()) {
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
          height: widget.height,
          child: Text(
            "LOGIN",
            style: login,
          ),
        ),
      ),
    );
  }
}
