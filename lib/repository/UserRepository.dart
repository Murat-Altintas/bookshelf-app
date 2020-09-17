import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grade_point_avarage/model/book.dart';
import 'package:grade_point_avarage/model/firebaseBook.dart';

class UserRepository {
  static final UserRepository _singleton = UserRepository._internal();

  factory UserRepository() {
    return _singleton;
  }

  UserRepository._internal();

  FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Item> loadedItems = [];
  List<Item> favoriteItems = [];

  String userName;

  Future<bool> createUser(
    String email,
    password,
    name,
  ) async {
    UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    final user = credential.user;
    await user.sendEmailVerification().catchError((e) => print("Email verification Error: $e"));

    await _firestore.collection("Users").doc(user.uid).set({
      "name": name,
    });
    return true;
  }

  Future<String> signIn(String email, String sifre) async {
    var credential = await _auth.signInWithEmailAndPassword(email: email, password: sifre);
    if (credential.user.emailVerified) {
      user = credential.user;
      return "Email verified is OK";
    }
    return "Email is not verified";
  }

  Future<void> getNickname() async {
    try {
      await _firestore.collection("Users").doc(user.uid).get().then((userData) {
        userName = (userData.data())["name"];
      });
    } catch (e) {
      print(e);
    }
  }

  Future<String> updateMail(String updateMail) async {
    await user.updateEmail(updateMail).then((value) {
      user.sendEmailVerification();
    });
    return "Verify your new email";
  }

  Future<String> updatePassword(String password) async {
    await user.updatePassword(password);
    return "Password update is complete";
  }

  Future<String> updateNickname(String nickname) async {
    final uid = user.uid;
    await _firestore.collection("Users").doc(uid).update({"name": nickname});
    userName = nickname;
    return "Nickname update is complete";
  }

  Future<void> saveBooks(allBook, favOrBookshelf) async {
    Map<String, String> idMap = Map();
    idMap[allBook.id] = allBook.id;
    final User user = _auth.currentUser;
    final uid = user.uid;

    String title = allBook.volumeInfo.title == null ? "NO DATA" : allBook.volumeInfo.title.toString();
    String authors = allBook.volumeInfo.authors == null ? "NO DATA" : allBook.volumeInfo.authors.first.toString();
    String publisher = allBook.volumeInfo.publisher == null ? "NO DATA" : allBook.volumeInfo.publisher.toString();
    String image = allBook.volumeInfo.imageLinks == null ? "NO DATA" : allBook.volumeInfo.imageLinks.thumbnail.toString();
    String bookID = idMap == null ? "NO DATA" : allBook.id;

    Map<String, String> mixMap = {
      "title": title,
      "authors": authors,
      "publisher": publisher,
      "image": image,
      "bookID": bookID,
    };

    if (favOrBookshelf == true) {
      await _firestore.collection("MyFavorites").doc(uid).collection("FavoriteBooks").doc(allBook.id).set(mixMap, SetOptions(merge: true));
    } else if (favOrBookshelf == false) {
      await _firestore.collection("MyBooks").doc(uid).collection("BookshelfBooks").doc(allBook.id).set(mixMap, SetOptions(merge: true));
    }
  }

  void cleanBooks() {
    loadedItems.clear();
  }

  Future<void> getBooks({String bookName, int startIndex = 10, bool clean = false}) async {
    var dio = Dio();
    var response = await dio.get("https://www.googleapis.com/books/v1/volumes?q=$bookName&startIndex=$startIndex");
    //        "https://www.googleapis.com/books/v1/volumes?q=$bookName+&langRestrict=tr&maxResults=20&startIndex=$startIndex"); //&maxResults=10&startIndex=$startIndex");
    Map data = await response.data;
    final booksResponse = Book.fromJson(data);
    if (clean) cleanBooks();
    loadedItems.addAll(booksResponse.items);
    print("Response:" + loadedItems[0].volumeInfo.title);
  }

  Future<void> deleteBook(String bookID, bool favOrBookshelf) async {
    final uid = user.uid;

    if (favOrBookshelf == true) {
      await _firestore.collection("MyFavorites").doc(uid).collection("FavoriteBooks").doc(bookID).delete();
    } else if (favOrBookshelf == false) {
      await _firestore.collection("MyBooks").doc(uid).collection("BookshelfBooks").doc(bookID).delete();
    }
  }

  Future<List<FirebaseBook>> getFavoriteBooks() async {
    final User user = _auth.currentUser;
    return (await _firestore.collection("MyFavorites").doc(user.uid).collection("FavoriteBooks").get())
        .docs
        .map((doc) => FirebaseBook.fromJson(doc.data()))
        .toList();
  }

  //--Controllers are here--//

  String nickControl(String value) {
    print(value);
    String regEx =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(regEx);
    RegExp re = RegExp(r'^[a-zA-Z0-9]+$');
    if (value.length == 0) {
      return "Please don't leave blank";
    } else if (!re.hasMatch(value)) {
      return "Please don't use special characters";
    } else {
      return null;
    }
  }

  String passwordControl(String value) {
    if (value.isEmpty) {
      return "Please don't leave blank";
    } else if (value.length <= 4 && value.length <= 20) {
      return "Password must be between 5-20 characters";
    } else {
      return null;
    }
  }

  String mailControl(String value) {
    String regEx =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(regEx);
    if (value.length == 0) {
      return "Please don't leave blank";
    } else if (!regExp.hasMatch(value)) {
      return "Please don't use special characters";
    } else {
      return null;
    }
  }
}
