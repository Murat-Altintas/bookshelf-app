import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grade_point_avarage/MasterPage.dart';
import 'package:grade_point_avarage/repository/UserRepository.dart';
import 'View/Images/ResaultImage.dart';
import 'package:grade_point_avarage/View/ContextExtension.dart';
import 'init/theme/BlueTheme.dart';
import 'model/book.dart';

class ResaultPage extends StatefulWidget {
  @override
  _ResaultPageState createState() => _ResaultPageState();
}

class _ResaultPageState extends State<ResaultPage> {
  int startIndex = 0;
  var bookName = TextEditingController();

  //------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ResaultImage(),
            searchBar(),
            SizedBox(
              height: context.lowestContainer,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CarouselSlider.builder(
                    itemCount: UserRepository().loadedItems.length,
                    options: CarouselOptions(
                        onPageChanged: (page, reason) {
                          if (page == UserRepository().loadedItems.length - 1) {
                            loadNextPage();
                            print("+10 page");
                          }
                        },
                        pauseAutoPlayOnTouch: true,
                        disableCenter: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.scale,
                        enlargeCenterPage: true,
                        viewportFraction: 0.6,
                        enableInfiniteScroll: false,
                        autoPlay: false,
                        autoPlayInterval: Duration(seconds: 4),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.decelerate,
                        height: context.height * 57),
                    itemBuilder: (BuildContext context, int index) {
                      Widget changeIcon = Icon(Icons.favorite_border);
                      return Container(
                          width: context.height * 55,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Ink(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5,
                                  offset: Offset(10, 0),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  child: UserRepository().loadedItems[index].volumeInfo.imageLinks != null
                                      ? Image.network(
                                          UserRepository().loadedItems[index].volumeInfo.imageLinks.thumbnail,
                                          height: context.height * 35,
                                          fit: BoxFit.fill,
                                        )
                                      : Center(child: Text("NO IMAGE", style: blueTheme.textTheme.headline1)),
                                  height: context.height * 30,
                                ),
                                SizedBox(
                                  height: context.lowestContainer,
                                ),
                                Text(
                                  UserRepository().loadedItems[index].volumeInfo.title == null ? "No data" : UserRepository().loadedItems[index].volumeInfo.title.toUpperCase(),
                                  style: blueTheme.primaryTextTheme.headline1.copyWith(fontSize: context.lowText),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                Text(
                                  UserRepository().loadedItems[index].volumeInfo.authors.toString() == null ? "No data" : UserRepository().loadedItems[index].volumeInfo.authors.toString().replaceAll("]", "").replaceAll("[  ", ""),
                                  style: blueTheme.primaryTextTheme.headline2.copyWith(fontSize: context.lowText),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  UserRepository().loadedItems[index].volumeInfo.publisher.toString() == null ? "No data" : UserRepository().loadedItems[index].volumeInfo.publisher.toString(),
                                  style: blueTheme.primaryTextTheme.headline3.copyWith(fontSize: context.lowText),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: context.height * 1,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    IconButton(
                                      icon: changeIcon,
                                      color: blueTheme.errorColor,
                                      onPressed: () {
                                        setState(() {
                                          if (changeIcon == Icon(Icons.favorite_border)) {
                                            changeIcon = Icon(Icons.favorite);
                                          }
                                          UserRepository().saveBookTitle(UserRepository().loadedItems[index]);
                                        });
                                      },
                                      iconSize: 30,
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.check_box_outline_blank),
                                      onPressed: () {},
                                      iconSize: 30,
                                      color: blueTheme.primaryColor,
                                    ),
                                    Text(
                                      "Sayfa sayısı: " + UserRepository().loadedItems[index].volumeInfo.pageCount.toString(),
                                      style: blueTheme.primaryTextTheme.headline3,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ));
                    },
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  searchBar() => Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: context.iconSize,
            color: blueTheme.primaryIconTheme.color,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MasterPage()));
            },
          ),
          Container(
            width: context.width * 70,
            child: TextField(
              controller: bookName,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20, top: 3),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: blueTheme.primaryColor, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(60)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(60.0)),
                  borderSide: BorderSide(color: blueTheme.primaryColor, width: 1),
                ),
                hintText: "Search your favorite book...",
                hintStyle: blueTheme.textTheme.headline2.copyWith(fontSize: context.normalText),
              ),
              onSubmitted: (s) async {
                UserRepository().getBooks(bookName: bookName.text);
                // print(allBook[0].items);
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            iconSize: context.iconSize,
            color: blueTheme.primaryIconTheme.color,
            onPressed: () async {
              UserRepository().getBooks(bookName: bookName.text);
            },
          ),
        ],
      );

  void loadNextPage() {
    UserRepository().getBooks(startIndex: startIndex += 10);
    UserRepository().getBooks(bookName: bookName.text);
  }
}
