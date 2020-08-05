import 'package:flutter/material.dart';
import 'package:grade_point_avarage/View/ContextExtension.dart';

class CoffeeImage extends StatefulWidget {
  final double;

  const CoffeeImage({Key key, this.double}) : super(key: key);

  @override
  _CoffeeImageState createState() => _CoffeeImageState();
}

class _CoffeeImageState extends State<CoffeeImage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
          alignment: Alignment.bottomLeft,
          child: Image.asset(
            "assets/images/loginCoffee.png",
            width: widget.double,
          )),
    );
  }
}
