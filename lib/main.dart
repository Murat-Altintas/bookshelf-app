import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:MobileBookshelf/BookshelfPage.dart';
import 'package:MobileBookshelf/CreateAccount.dart';
import 'package:MobileBookshelf/FavoritesPage.dart';
import 'package:MobileBookshelf/LoginPage.dart';
import 'package:MobileBookshelf/MasterPage.dart';
import 'package:MobileBookshelf/OptionsPage.dart';
import 'package:MobileBookshelf/ResaultPage.dart';
import 'package:MobileBookshelf/View/Images/ResaultImage.dart';
import 'package:MobileBookshelf/repository/UserRepository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GradePoint());
}

class GradePoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool logged=false;
  @override
  Widget build(BuildContext context) {
    if(UserRepository().user!=null)
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: FutureBuilder(
        future: UserRepository().getNickname(),
        builder: (_, snap) {
          if (snap.connectionState == ConnectionState.done) {
            return LoginPage();
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
    else return LoginPage();
  }
}