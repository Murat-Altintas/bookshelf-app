import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/services.dart';

class UserRepository {
  FirebaseAuth firebaseAuth;

  UserRepository() {
    this.firebaseAuth = FirebaseAuth.instance;
  }

  Future<FirebaseUser> createUser(String email, String password) async {
    try {
      var resault = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return resault.user;
    } on PlatformException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<FirebaseUser> signInUser(String email, String password) async {
    var resault = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return resault.user;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async {
    var currentUser = await firebaseAuth.currentUser();
    return currentUser != null;
  }


}
