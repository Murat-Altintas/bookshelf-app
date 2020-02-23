import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'style.dart';

class MasterPage extends StatefulWidget {
  @override
  MasterPageState createState() => MasterPageState();
}

class MasterPageState extends State<MasterPage> {
  @override
  Widget build(BuildContext context) {
    Widget searchBar() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20, top: 3),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: mainBlue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 1),
                  ),
                  hintText: "Search your book...",
                  hintStyle: search,
                ),
              ),
            ),
            RawMaterialButton(
              splashColor: Colors.purple,
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
              fillColor: mainBlue,
            ),
          ],
        );
    var bgGradient = Container(
      height: SizeConfig.blockSizeVertical * 60,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
            0.1,
            1
          ],
              colors: [
            Colors.lightBlueAccent.shade100,
            Colors.indigoAccent.shade100
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
                height: SizeConfig.blockSizeVertical * 45,
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
            Align(
              alignment: Alignment(1, .25),
              child: searchBar(),
            ),
          ],
        ),
      ),
    );
  }
}

//------------------------------------------------//
/*
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      color: Colors.green,
                      width: 170,
                      height: 170,
                    ),
                    Container(
                      color: Colors.green,
                      width: 170,
                      height: 170,
                    ),
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                searchBar(),
              ],
            ),
            */
//------------------------------------------------//
