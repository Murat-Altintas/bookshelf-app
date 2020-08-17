import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum UserDurumu { Idle, OturumAcilmamis, OturumAciliyor, OturumAcik }

class UserRepository {
  FirebaseAuth _auth;
  FirebaseUser _user;
  Firestore firestore;
  UserDurumu _durum = UserDurumu.Idle;

  FirebaseUser get user => _user;

  set user(FirebaseUser value) {
    _user = value;
  }

  UserDurumu get durum => _durum;

  set durum(UserDurumu value) {
    _durum = value;
  }

  Future<bool> createUser(String email, password, name, surname) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: password).then((userID) async {
      userID.user.uid;

      Map<dynamic, dynamic> userMap = {
        "name": name,
        "surname": surname,
      };

      firestore.collection("Users").document("").setData(userMap);
    });

    return true;
  }

  Future<bool> signIn(String email, String sifre) async {
    try {
      _durum = UserDurumu.OturumAciliyor;
      _auth.signInWithEmailAndPassword(email: email, password: sifre);
      return true;
    } catch (e) {
      _durum = UserDurumu.OturumAcilmamis;
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _durum = UserDurumu.OturumAcilmamis;
    return Future.delayed(Duration.zero);
  }

  UserRepository() {
    _auth = FirebaseAuth.instance;
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(FirebaseUser user) async {
    if (user == null) {
      _durum = UserDurumu.OturumAcilmamis;
    } else {
      _user = user;
      _durum = UserDurumu.OturumAcik;
    }}

  Future<void> nameSurname(String name, surname) async {
    Map<String, dynamic> userMap = Map();
    userMap[name] = "name";
    userMap[surname] = "surname";
    await firestore.collection("user").document().setData(userMap).then((value) => print("complate"));
  }

  String nameControl(String value) {
    String regEx =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(regEx);
    if (value.length == 0) {
      return "Write your name";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid name";
    } else {
      return null;
    }
  }

  String surnameControl(String value) {
    String regEx =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(regEx);
    if (value.length == 0) {
      return "Write your surname";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid surname";
    } else {
      return null;
    }
  }

  String mailControl(String value) {
    String regEx =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(regEx);
    if (value.length == 0) {
      return "Write your e-mail";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid e-mail";
    } else {
      return null;
    }
  }

  String passwordControl(String value) {
    if (value.isEmpty) {
      return "Write your password";
    } else if (value.length <= 4 && value.length <= 20) {
      return "Password must be between 5-20 characters";
    } else {
      return null;
    }
  }
}
