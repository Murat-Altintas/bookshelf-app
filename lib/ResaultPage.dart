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
  UserRepository userRepo = UserRepository();
  List<String> favoriIDs=[];
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
                    itemCount: userRepo.loadedItems.length,
                    options: CarouselOptions(
                        onPageChanged: (page, reason) {
                          if (page == userRepo.loadedItems.length - 1) {
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
                                  child: userRepo.loadedItems[index].volumeInfo.imageLinks != null
                                      ? Image.network(
                                          userRepo.loadedItems[index].volumeInfo.imageLinks.thumbnail,
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
                                  userRepo.loadedItems[index].volumeInfo.title == null
                                      ? "No data"
                                      : userRepo.loadedItems[index].volumeInfo.title.toUpperCase(),
                                  style: blueTheme.primaryTextTheme.headline1.copyWith(fontSize: context.lowText),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                Text(
                                  userRepo.loadedItems[index].volumeInfo.authors.toString() == null
                                      ? "No data"
                                      : userRepo.loadedItems[index].volumeInfo.authors.toString().replaceAll("]", "").replaceAll("[", ""),
                                  style: blueTheme.primaryTextTheme.headline2.copyWith(fontSize: context.lowText),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  userRepo.loadedItems[index].volumeInfo.publisher.toString() == null
                                      ? "No data"
                                      : userRepo.loadedItems[index].volumeInfo.publisher.toString(),
                                  style: blueTheme.primaryTextTheme.headline3.copyWith(fontSize: context.lowText),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: context.height * 1,
                                ),
                                 iconBar(userRepo.loadedItems[index]),
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
                userRepo.getBooks(bookName: bookName.text);
                // print(allBook[0].items);
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            iconSize: context.iconSize,
            color: blueTheme.primaryIconTheme.color,
            onPressed: () async {
              userRepo.getBooks(reset: true,bookName: bookName.text).whenComplete(() {
                setState(() {
                  print("Response:" + userRepo.loadedItems[0].volumeInfo.title);
                });
              });
            },
          ),
        ],
      );

  void loadNextPage() {
    userRepo.getBooks(bookName: bookName.text, startIndex: startIndex += 10);
  }

  Widget iconBar(Item loadedItem) {
    bool changeIcon ;
    if(favoriIDs.contains(loadedItem.id)){
      changeIcon=false;
    }else changeIcon=true;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          icon: changeIcon? Icon(Icons.favorite_border):Icon(Icons.favorite),
          color: blueTheme.errorColor,
          onPressed: () {
            setState(() {
              if(changeIcon)
              favoriIDs.add(loadedItem.id);
              else{
                favoriIDs.remove(loadedItem.id);
              }
              userRepo.saveBookTitle(loadedItem);
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
          "Sayfa sayısı: " + loadedItem.volumeInfo.pageCount.toString(),
          style: blueTheme.primaryTextTheme.headline3,
        ),
      ],
    );
  }
}
