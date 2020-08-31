
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grade_point_avarage/model/book.dart';

class UserRepository {

  static final UserRepository _singleton = UserRepository._internal();

  factory UserRepository() {
    return _singleton;
  }

  UserRepository._internal();

  FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Item> loadedItems = [];
  String userName;

  Future<bool> createUser(String email, password, name, surname) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
    final uid = _user.uid;
    Map<String, String> userMap = {
      "name": name,
      "surname": surname,
    };
    _firestore.collection("Users").doc(uid).set(userMap);
    return true;
  }

  Future<bool> signIn(String email, String sifre) async {
    var credential = await _auth.signInWithEmailAndPassword(email: email, password: sifre);
    _user= credential.user;
    return true;
  }

  Future<void> saveBooks(allBook, favOrBookshelf) async {
    Map<String, String> idMap = Map();
    idMap[allBook.id] = allBook.id;
    final User user =  _auth.currentUser;
    final uid = user.uid;

    String title = allBook.volumeInfo.title == null ? "NO DATA" : allBook.volumeInfo.title.toString();
    String authors = allBook.volumeInfo.authors == null ? "NO DATA" : allBook.volumeInfo.authors.first.toString();
    String publisher = allBook.volumeInfo.publisher == null ? "NO DATA" : allBook.volumeInfo.publisher.toString();
    String image = allBook.volumeInfo.imageLinks == null ? "NO DATA" : allBook.volumeInfo.imageLinks.thumbnail.toString();

    Map<String, String> mixMap = {
      "title": title,
      "authors": authors,
      "publisher": publisher,
      "image": image,
    };

    if (favOrBookshelf == true) {
      await _firestore.collection("MyFavorites").doc(uid).collection("FavoriteBooks").doc("$idMap").set(mixMap,SetOptions(merge: true));
    } else if (favOrBookshelf == false) {
      await _firestore.collection("MyBooks").doc(uid).collection("BookshelfBooks").doc("$idMap").set(mixMap, SetOptions(merge: true));
    }
  }

  Future<void> deleteBook(allBook, favOrBookshelf) async {
    Map<String, String> idMap = Map();
    idMap[allBook.id] = allBook.id;
    
    final uid = _user.uid;

    if (favOrBookshelf == true) {
      await _firestore.collection("MyFavorites").doc(uid).collection("FavoriteBooks").doc("$idMap").delete();
    } else if (favOrBookshelf == false) {
      await _firestore.collection("MyBooks").doc(uid).collection("BookshelfBooks").doc("$idMap").delete();
    }
  }

  Future<void> getBooks({String bookName, int startIndex = 10, bool reset = false}) async {
    print("name:" + bookName);
    if (reset) loadedItems.clear();
    var dio = Dio();
    var response = await dio.get(
        "https://www.googleapis.com/books/v1/volumes?q=$bookName+&langRestrict=tr&maxResults=10&startIndex=$startIndex"); //&maxResults=10&startIndex=$startIndex");
    Map data = await response.data;
    final booksResponse = Book.fromJson(data);
    loadedItems.addAll(booksResponse.items);
    print("Response:" + loadedItems[0].volumeInfo.title);
  }

  Future<String> getUserName() async {
    try {
        return await _firestore.collection("Users").doc(_user.uid).get().then((userData) {
          return (userData.data())["name"];
        });
      
    } catch (e) {
      print(e);
      return "null";
    }
  }

  //----------------------------------------------------------------------------------//

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
