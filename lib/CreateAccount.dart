import 'package:flutter/material.dart';
import 'package:grade_point_avarage/LoginPage.dart';
import 'package:grade_point_avarage/View/BlueButtons.dart';
import 'package:grade_point_avarage/View/ContextExtension.dart';
import 'package:grade_point_avarage/repository/UserRepository.dart';
import 'View/TextFields.dart';
import 'View/Images/CoffeeImage.dart';
import 'init/theme/BlueTheme.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

var nameText = TextEditingController();
var surnameText = TextEditingController();
var mailText = TextEditingController();
var passwordText = TextEditingController();
var _formKey = GlobalKey<FormState>();
bool autoControl = false;
bool obscureText = true;

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _formKey,
        autovalidate: autoControl,
        child: SafeArea(
          child: Padding(
            padding: context.paddingMedium,
            child: LayoutBuilder(builder: (context, constraints) {
              return constraints.maxWidth < 400
                  ? Column(
                      children: [
                        Container(
                          height: context.height * 35,
                          child: Image.asset("assets/images/createAccount.png"),
                        ),
                        SizedBox(
                          height: context.lowestContainer,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: context.width * 43,
                              child: TextFields(
                                validator: UserRepository().nameControl,
                                obscureText: false,
                                controller: nameText,
                                hintText: "NAME",
                                textStyle: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
                              ),
                            ),
                            Container(
                              width: context.width * 43,
                              child: TextFields(
                                validator: UserRepository().surnameControl,
                                obscureText: false,
                                controller: surnameText,
                                hintText: "SURNAME",
                                textStyle: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
                              ),
                            ),
                          ],
                        ),
                        //----------------------------------------------------------------------------------------//
                        TextFields(
                          obscureText: false,
                          controller: mailText,
                          hintText: "E-MAIL",
                          textStyle: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
                          validator: UserRepository().mailControl,
                        ),
                        SizedBox(
                          height: context.fieldSpaceContainer,
                        ),
                        TextFields(
                          suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye), onPressed: _showPassword),
                          controller: passwordText,
                          hintText: "PASSWORD",
                          obscureText: true,
                          textStyle: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
                          validator: UserRepository().passwordControl,
                        ),
                        SizedBox(
                          height: context.fieldSpaceContainer,
                        ),
                        BlueButtons(
                          onTap: () {
                            UserRepository().nameSurname(nameText.toString(), surnameText.toString());
                            print("$nameText, $surnameText ");
                            /*
                            if (_formKey.currentState.validate()) {
                              UserRepository().createUser(
                                  mailText.text, String, passwordText.text);
                            }
                          */
                          },
                          incomingText: "CREATE ACCOUNT",
                        ),
                        SizedBox(
                          height: context.lowestContainer,
                        ),
                        BlueButtons(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                          },
                          incomingText: "LOGIN",
                        ),

                        SizedBox(
                          height: context.fieldSpaceContainer,
                        ),
                        CoffeeImage(
                          double: context.height * 15,
                        ),
                        SizedBox(
                          height: context.fieldSpaceContainer,
                        ),
                      ],
                    )
                  : Column(
                      children: <Widget>[
                        Container(
                          height: context.height * 30,
                          child: Image.asset("assets/images/createAccount.png"),
                        ),
                        SizedBox(
                          height: context.heighContainer,
                        ),
                        TextFields(
                          controller: mailText,
                          hintText: "E-MAIL",
                          textStyle: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
                          validator: UserRepository().mailControl,
                        ),
                        TextFields(
                          controller: passwordText,
                          hintText: "PASSWORD",
                          suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye), onPressed: _showPassword),
                          textStyle: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
                          validator: UserRepository().passwordControl,
                        ),
                        SizedBox(
                          height: context.lowContainer,
                        ),
                        BlueButtons(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                          },
                          incomingText: "LOGIN",
                        ),
                        SizedBox(
                          height: context.lowestContainer,
                        ),
                        CoffeeImage(
                          double: context.height * 15,
                        ),
                        SizedBox(
                          height: context.lowestContainer,
                        ),
                      ],
                    );
            }),
          ),
        ),
      ),
    );
  }

  void _showPassword() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
