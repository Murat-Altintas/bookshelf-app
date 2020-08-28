import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grade_point_avarage/model/book.dart';

class UserRepository {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  Firestore _firestore = Firestore.instance;
  List<Item> loadedItems = [];
  String userName;

  Future<bool> createUser(String email, password, name, surname) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
    final uid = _user.uid;
    Map<String, String> userMap = {
      "name": name,
      "surname": surname,
    };
    _firestore.collection("Users").document(uid).setData(userMap);
    return true;
  }

  Future<bool> signIn(String email, String sifre) async {
    await _auth.signInWithEmailAndPassword(email: email, password: sifre);
    return true;
  }

  Future<void> saveBooks(allBook, FavOrBookshelf) async {
    Map<String, String> idMap = Map();
    idMap[allBook.id] = allBook.id;
    final FirebaseUser user = await _auth.currentUser();
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

    if (FavOrBookshelf == true) {
      await _firestore.collection("MyFavorites").document(uid).collection("FavoriteBooks").document("$idMap").setData(mixMap, merge: true);
    } else if (FavOrBookshelf == false) {
      await _firestore.collection("MyBooks").document(uid).collection("BookshelfBooks").document("$idMap").setData(mixMap, merge: true);
    }
  }

  Future<void> deleteBook(allBook, FavOrBookshelf) async {
    Map<String, String> idMap = Map();
    idMap[allBook.id] = allBook.id;
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;

    if (FavOrBookshelf == true) {
      await _firestore.collection("MyFavorites").document(uid).collection("FavoriteBooks").document("$idMap").delete();
    } else if (FavOrBookshelf == false) {
      await _firestore.collection("MyBooks").document(uid).collection("BookshelfBooks").document("$idMap").delete();
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
      return await _auth.currentUser().then((urs) async {
        return await _firestore.collection("Users").document(urs.uid).get().then((userData) {
          return userData.data["name"];
        });
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
