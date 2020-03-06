import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ResaultPage.dart';
import 'style.dart';

class MasterPage extends StatefulWidget {
  @override
  MasterPageState createState() => MasterPageState();
}

class MasterPageState extends State<MasterPage> {
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
    var bgGradient = Container(
      child: Padding(
        padding: const EdgeInsets.all(20),
      ),
      height: heightSize(100),
      width: widthSize(100),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.1, 1],
              colors: [Colors.purple.shade300, Colors.pink.shade300])),
    );
    var welcome = RichText(
      text: TextSpan(
        text: "Welcome",
        style: TextStyle(
          fontSize: heightSize(4),
          color: Colors.purple,
          fontFamily: 'MainFont',
          fontWeight: FontWeight.w700,
        ),
        children: <TextSpan>[
          TextSpan(
            text: ' to your bookshelf...',
            style: TextStyle(
              fontSize: heightSize(4),
              color: Colors.purple,
              fontFamily: 'MainFont',
              fontWeight: FontWeight.w300,
            ),
          )
        ],
      ),
    );
    var welcomeText = Row(
      children: <Widget>[
        SizedBox(
          width: widthSize(5),
        ),
        welcome,
        SizedBox(
          height: heightSize(5),
        ),
      ],
    );
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // bgGradient,
          Positioned(
            top: heightSize(8),
            left: widthSize(3),
            child: SizedBox(
              height: heightSize(37),
              child: Image.asset("assets/images/topsearch.png"),
            ),
          ),
          Positioned(
            top: heightSize(42),
            child: Container(
              width: SizeConfig.screenWidth,
              height: heightSize(70),
              decoration: BoxDecoration(
                //color: Colors.purple.shade100,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: heightSize(47),
              ),
              welcomeText,
              SizedBox(
                height: heightSize(2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResaultPage()));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: widthSize(28),
                            height: heightSize(14),
                            child:
                                Image.asset("assets/images/my_bookshelf2.png"),
                          ),
                          Text("search book"),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(
                height: heightSize(2),
              ),

            ],
          ),
        ],
      ),
    );
  }
}

/*


 */
