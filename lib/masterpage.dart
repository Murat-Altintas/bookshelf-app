import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    Widget searchBar() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: widthSize(75),
              child: TextField(
                decoration: InputDecoration(

                  contentPadding: EdgeInsets.only(left: 20, top: 3),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    borderSide: BorderSide(color: Colors.purple, width: 1),
                  ),
                  hintText: "Search your book...",
                  hintStyle: search,
                ),
              ),
            ),
            RawMaterialButton(
              splashColor: Colors.yellow,
              onPressed: () {},
              elevation: 20,
              child: Icon(
                Icons.search,
                size: iconSize,
                color: Colors.white,
              ),
              constraints: BoxConstraints.tightFor(
                height: SizeConfig.blockSizeVertical * 7,
                width: SizeConfig.blockSizeVertical * 7,
              ),
              shape: CircleBorder(),
              fillColor: Colors.purple,
            ),
          ],
        );
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
              stops: [
            0.1,
            1
          ],
              colors: [
            Colors.pink.shade300,
            Colors.yellow.shade300
          ])),
    );
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            bgGradient,
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                child: Image.asset("assets/images/topsearch.png"),
              ),
            ),
            Align(
              alignment: Alignment(1, 1.05),
              child: Container(
                width: SizeConfig.screenWidth,
                height: heightSize(50),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                  height: heightSize(50),
                ),
                searchBar(),
                SizedBox(
                  height: heightSize(2),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: widthSize(28),
                            height: heightSize(14),
                            child:
                                Image.asset("assets/images/my_bookshelf.png"),
                          ),
                          Text("my bookshelf"),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: widthSize(28),
                            height: heightSize(14),
                            child:
                            Image.asset("assets/images/my_favorites.png"),
                          ),
                          Text("my favorites"),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: widthSize(28),
                            height: heightSize(14),
                            child:
                            Image.asset("assets/images/my_acquisitions.png"),
                          ),
                          Text("my acquisitions"),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: heightSize(2),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: widthSize(28),
                            height: heightSize(14),
                            child:
                            Image.asset("assets/images/my_notes.png"),
                          ),
                          Text("my notes"),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: widthSize(28),
                            height: heightSize(14),
                            child:
                            Image.asset("assets/images/my_userpanel.png"),
                          ),
                          Text("my user panel"),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: widthSize(28),
                            height: heightSize(14),
                            child:
                            Image.asset("assets/images/about_us.png"),
                          ),
                          Text("about us"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
