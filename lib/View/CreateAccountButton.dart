import 'package:flutter/material.dart';
import 'package:grade_point_avarage/init/theme/BlueTheme.dart';
import 'package:grade_point_avarage/View/ContextExtension.dart';


class CreateAccountButton extends StatefulWidget {
  final textStyle;

  const CreateAccountButton({Key key, this.textStyle}) : super(key: key);

  @override
  _CreateAccountButtonState createState() => _CreateAccountButtonState();
}

class _CreateAccountButtonState extends State<CreateAccountButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccountButton()));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(60)),
        child: Container(
          alignment: Alignment.center,
          color: blueTheme.primaryColor,
          height: context.mediumContainer,
          child: Text(
            "CREATE ACCOUNT",
            style: widget.textStyle,
          ),
        ),
      ),
    );
  }
}
