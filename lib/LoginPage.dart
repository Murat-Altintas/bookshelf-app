import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grade_point_avarage/MasterPage.dart';
import 'package:grade_point_avarage/View/BlueButtons.dart';
import 'CreateAccount.dart';
import 'View/Images/CoffeeImage.dart';
import 'View/ContextExtension.dart';
import 'View/TextFields.dart';
import 'package:grade_point_avarage/repository/UserRepository.dart';
import 'init/theme/BlueTheme.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool autoControl = false;
  var formKey = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: formKey,
        autovalidate: autoControl,
        child: SafeArea(
          child: Padding(
            padding: context.paddingMedium,
            child: LayoutBuilder(builder: (context, constraints) {
              return constraints.maxWidth < 400
                  ? Column(
                      children: [
                        Container(
                          height: context.height * 30,
                          child: Image.asset("assets/images/loginPage.png"),
                        ),
                        SizedBox(
                          height: context.lowestContainer,
                        ),
                        SizedBox(
                          height: context.fieldSpaceContainer,
                        ),
                        TextFields(
                          validator: UserRepository().mailControl,
                          obscureText: false,
                          controller: mailText,
                          hintText: "MAIL",
                          textStyle: blueTheme.textTheme.headline2
                              .copyWith(fontSize: context.normalText),
                        ),
                        SizedBox(
                          height: context.lowestContainer,
                        ),
                        TextFields(
                          validator: UserRepository().passwordControl,
                          obscureText: obscureText,
                          suffixIcon: IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              onPressed: _showPassword),
                          controller: passwordText,
                          hintText: "PASSWORD",
                          textStyle: blueTheme.textTheme.headline2
                              .copyWith(fontSize: context.normalText),
                        ),
                        SizedBox(
                          height: context.lowContainer,
                        ),
                        BlueButtons(
                          onTap: () {
                            if (formKey.currentState.validate()) {
                              UserRepository()
                                  .signIn(mailText.text, passwordText.text)
                                  .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => MasterPage())));
                            }
                          },
                          incomingText: "LOGIN",
                        ),
                        SizedBox(
                          height: context.lowestContainer,
                        ),
                        BlueButtons(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateAccount()));
                          },
                          incomingText: "CREATE ACCOUNT",
                        ),
                        SizedBox(
                          height: context.lowestContainer,
                        ),
                        CoffeeImage(
                          double: context.height * 20,
                        ),
                        SizedBox(
                          height: context.height * 1,
                        ),
                      ],
                    )
                  : Column(
                      children: <Widget>[
                        Container(
                          height: context.height * 10,
                          child: Image.asset("assets/images/loginPage.png"),
                        ),
                        SizedBox(
                          height: context.height * 3,
                        ),
                        BlueButtons(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateAccount()));
                          },
                          incomingText: "CREATE ACCOUNT",
                        ),
                        CoffeeImage(
                          double: context.height * 15,
                        ),
                        SizedBox(
                          height: context.height * 3,
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
