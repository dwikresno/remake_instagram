// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instagram_new/data/listcategory.dart';
import 'package:instagram_new/data/listdata.dart';
import 'package:instagram_new/ui/explore/ImageTile.dart';
import 'package:instagram_new/viewmodel/theme_view_model.dart';

class ExplorePage extends StatefulWidget {
  ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeViewModel>(builder: (tx) {
      return SafeArea(
        top: true,
        child: Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              print('refresh');
            },
            child: CustomScrollView(
              // physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              slivers: <Widget>[
                SliverAppBar(
                  floating: false,
                  pinned: false,
                  snap: false,
                  primary: true,
                  elevation: 0,
                  backgroundColor: tx.themeColor,
                  // leading: Container(
                  //   padding: EdgeInsets.fromLTRB(18, 18, 0, 18),
                  //   child: FaIcon(
                  //     FontAwesomeIcons.search,
                  //     size: 20,
                  //     color: Colors.black,
                  //   ),
                  // ),
                  title: GestureDetector(
                    onTap: () {
                      print('goes to search');
                    },
                    child: Text(
                      'Search',
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: "Coves",
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  // centerTitle: true,
                  // flexibleSpace: FlexibleSpaceBar(
                  //   background: ,
                  // ),
                  actions: <Widget>[
                    Container(
                        padding: EdgeInsets.all(15),
                        child: Icon(
                          Icons.fullscreen,
                          color: Colors.black,
                          size: 28,
                        ))
                  ],
                ),
                SliverStickyHeader.builder(
                  builder: (context, state) {
                    return Container(
                      height: 50.0,
                      color: tx.themeColor,
                      // padding: EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          // padding: const EdgeInsets.all(8),
                          itemCount: category.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Neumorphic(
                                style: NeumorphicStyle(
                                    shape: NeumorphicShape.concave,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(12)),
                                    depth: 3,
                                    lightSource: LightSource.topLeft,
                                    color: tx.themeColor),
                                margin: EdgeInsets.all(7),
                                padding: EdgeInsets.only(left: 20, right: 20),
                                // height: 8,
                                // // width: 100,
                                child: Center(
                                  child: Row(
                                    children: <Widget>[
                                      index == 0
                                          ? Container(
                                              padding: EdgeInsets.all(4),
                                              child: FaIcon(
                                                FontAwesomeIcons.tv,
                                                size: 12,
                                              ),
                                            )
                                          : index == 1
                                              ? Container(
                                                  padding: EdgeInsets.all(4),
                                                  child: FaIcon(
                                                    FontAwesomeIcons
                                                        .bagShopping,
                                                    size: 12,
                                                  ),
                                                )
                                              : Container(),
                                      Text('${category[index]['name']}'),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  },
                  sliver: SliverToBoxAdapter(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 35.0,
                        maxHeight: MediaQuery.of(context).size.height * 10000,
                      ),
                      child: MasonryGridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        itemBuilder: (context, index) {
                          final width = MediaQuery.of(context).size.width ~/ 3;
                          return ImageTile(
                            index: index + 1,
                            width: width,
                            height: isLong(index + 1) ? (width * 2) + 4 : width,
                            isLong: isLong(index + 1),
                          );
                        },
                        itemCount: 100,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  bool isLong(index) {
    if (index < 10) {
      if (index.toString().contains('3') || index.toString().contains('6')) {
        return true;
      }
    } else {
      if (index.toString()[1] == "3" || index.toString()[1] == "6") {
        return true;
      }
    }

    return false;
  }
}
