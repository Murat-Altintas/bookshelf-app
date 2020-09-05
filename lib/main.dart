import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grade_point_avarage/BookshelfPage.dart';
import 'package:grade_point_avarage/CreateAccount.dart';
import 'package:grade_point_avarage/FavoritesPage.dart';
import 'package:grade_point_avarage/LoginPage.dart';
import 'package:grade_point_avarage/MasterPage.dart';
import 'package:grade_point_avarage/OptionsPage.dart';
import 'package:grade_point_avarage/ResaultPage.dart';
import 'package:grade_point_avarage/View/Images/ResaultImage.dart';
import 'package:grade_point_avarage/repository/UserRepository.dart';

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
      title: "Flutter",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: FutureBuilder(
        future: UserRepository().getNickname(),
        builder: (_, snap) {
          if (snap.connectionState == ConnectionState.done) {
            return FavoritesPage();
            //return MasterPage(userName: snap.data);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}