import 'dart:async';
import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:instagram_new/ui/explore/explore.dart';
import 'package:instagram_new/ui/home/HomePage.dart';
import 'package:instagram_new/ui/profile/profile_view.dart';
import 'package:instagram_new/ui/reel/ReelsPage.dart';
import 'package:instagram_new/viewmodel/theme_view_model.dart';

class MainTabPage extends StatefulWidget {
  MainTabPage({Key? key}) : super(key: key);

  @override
  _MainTabmenutate createState() => _MainTabmenutate();
}

class _MainTabmenutate extends State<MainTabPage>
    with TickerProviderStateMixin {
  List<Widget>? pages;
  var widthTabBar = 50.0;
  var widthOpenBtn = 0.0;
  var selectedMenu = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  final pageController = PageController();
  DateTime? backButtonPressTime;
  static const snackBarDuration = Duration(seconds: 2);
  final ThemeViewModel themeViewModel = Get.put(ThemeViewModel());

  _onItemTapped(index) async {
    setState(() {
      widthTabBar = 0.0;
      widthOpenBtn = 25.0;
      selectedMenu = index;
      pageController.jumpToPage(index);
    });
    print(selectedMenu);
  }

  @override
  void initState() {
    pages = [
      Container(
        key: PageStorageKey(UniqueKey()),
        child: HomePage(),
      ),
      Container(
        key: PageStorageKey(UniqueKey()),
        child: ExplorePage(),
      ),
      Container(
        key: PageStorageKey(UniqueKey()),
        child: ReelsPage(),
      ),
      Container(
        key: PageStorageKey(UniqueKey()),
        child: Container(),
      ),
      Container(
        key: PageStorageKey(UniqueKey()),
        child: ProfileView(),
      ),
    ];
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      selectedMenu = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: GetBuilder<ThemeViewModel>(builder: (tx) {
          return Stack(
            children: [
              GestureDetector(
                onTapUp: (value) {
                  setState(() {
                    widthTabBar = 0.0;
                    widthOpenBtn = 25.0;
                  });
                },
                onTapDown: (value) {
                  setState(() {
                    widthTabBar = 0.0;
                    widthOpenBtn = 25.0;
                  });
                },
                onTap: () {
                  setState(() {
                    widthTabBar = 0.0;
                    widthOpenBtn = 25.0;
                  });
                },
                child: PageStorage(
                  bucket: bucket,
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    onPageChanged: onPageChanged,
                    children: pages!,
                  ),
                ),
              ),
              tx.isNavBarBottom
                  ? SafeArea(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 40,
                          color:
                              selectedMenu != 2 ? tx.themeColor : Colors.black,
                          child: Row(
                            children: menu(tx),
                          ),
                        ),
                      ),
                    )
                  : SafeArea(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 2.2,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widthTabBar = widthTabBar > 0.0 ? 0.0 : 50;
                                    widthOpenBtn = 0.0;
                                  });
                                },
                                child: Visibility(
                                  visible: selectedMenu != 2,
                                  child: AnimatedContainer(
                                    duration: Duration(seconds: 1),
                                    curve: Curves.fastOutSlowIn,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        bottomLeft: Radius.circular(50),
                                      ),
                                      color: tx.themeColor,
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.grey[200]!,
                                      ),
                                    ),
                                    width: widthOpenBtn,
                                    height: 35,
                                    child: Center(
                                      child: Icon(
                                        Icons.arrow_back_ios_new_rounded,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          widthTabBar =
                                              widthTabBar > 0.0 ? 0.0 : 50;
                                          widthOpenBtn = 0.0;
                                        });
                                        Timer(Duration(seconds: 3), () {
                                          setState(() {
                                            widthOpenBtn = 25.0;
                                            widthTabBar = 0;
                                          });
                                        });
                                      },
                                      child: Visibility(
                                        visible: selectedMenu == 2,
                                        child: AnimatedContainer(
                                          duration: Duration(seconds: 1),
                                          curve: Curves.fastOutSlowIn,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(50),
                                              bottomLeft: Radius.circular(50),
                                            ),
                                            color: tx.themeColor,
                                          ),
                                          width: widthOpenBtn,
                                          height: 35,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              left: 1,
                                              top: 1,
                                              bottom: 1,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(50),
                                                bottomLeft: Radius.circular(50),
                                              ),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons
                                                    .arrow_back_ios_new_rounded,
                                                color: selectedMenu == 2
                                                    ? Colors.white
                                                    : tx.themeTextColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: AnimatedContainer(
                                        width: widthTabBar,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2.5,
                                        decoration: BoxDecoration(
                                          color: selectedMenu != 2
                                              ? tx.themeColor
                                              : Colors.black,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            // bottomLeft: Radius.circular(20),
                                          ),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.grey[200]!,
                                          ),
                                        ),
                                        duration: Duration(seconds: 1),
                                        curve: Curves.fastOutSlowIn,
                                        child: Column(
                                          children: menu(tx),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          );
        }),
      ),
    );
  }

  List<Widget> menu(ThemeViewModel tx) {
    var menu = [
      Expanded(
        child: GestureDetector(
          onTap: () {
            _onItemTapped(0);
          },
          child: Container(
            child: SvgPicture.asset(
              selectedMenu == 0
                  ? 'assets/svg/navbar/home-on.svg'
                  : 'assets/svg/navbar/home-off.svg',
              width: 22,
              color: selectedMenu == 2 ? Colors.white : tx.themeTextColor,
            ),
          ),
        ),
      ),
      Expanded(
        child: GestureDetector(
          onTap: () {
            _onItemTapped(1);
          },
          child: Container(
            child: SvgPicture.asset(
              selectedMenu == 1
                  ? 'assets/svg/navbar/search-on.svg'
                  : 'assets/svg/navbar/search-off.svg',
              width: 22,
              color: selectedMenu == 2 ? Colors.white : tx.themeTextColor,
            ),
          ),
        ),
      ),
      Expanded(
        child: GestureDetector(
          onTap: () {
            _onItemTapped(2);
          },
          child: Container(
            child: SvgPicture.asset(
              selectedMenu == 2
                  ? 'assets/svg/navbar/reels-on.svg'
                  : 'assets/svg/navbar/reels-off.svg',
              width: 22,
              color: selectedMenu == 2 ? Colors.white : tx.themeTextColor,
            ),
          ),
        ),
      ),
      Expanded(
        child: GestureDetector(
          onTap: () {
            _onItemTapped(3);
          },
          child: Container(
            child: SvgPicture.asset(
              selectedMenu == 3
                  ? 'assets/svg/navbar/shopping-on.svg'
                  : 'assets/svg/navbar/shopping-off.svg',
              width: 22,
              color: selectedMenu == 2 ? Colors.white : tx.themeTextColor,
            ),
          ),
        ),
      ),
      Expanded(
        child: GestureDetector(
          onTap: () {
            _onItemTapped(4);
          },
          child: Center(
            child: tx.imagePP == null
                ? CircleAvatar(
                    radius: 15,
                    backgroundImage:
                        NetworkImage("https://picsum.photos/500/500?random=1"))
                : CircleAvatar(
                    radius: 15,
                    backgroundImage: FileImage(
                      File(tx.imagePP!.path),
                    ),
                  ),
          ),
        ),
      ),
    ];
    return menu;
  }

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();

    bool backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            currentTime.difference(backButtonPressTime!) > snackBarDuration;
    //print(controllerMain);
    if (selectedMenu != 0) {
      setState(() {
        selectedMenu = 0;
        pageController.jumpToPage(selectedMenu);
      });
      return false;
    }

    // if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
    //   backButtonPressTime = currentTime;
    //   // Scaffold.of(context).showSnackBar(snackBar);

    //   // Toast.show('Tekan sekali lagi untuk keluar JOIM', context,
    //   //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    //   Fluttertoast.showToast(
    //       msg: "Tekan sekali lagi untuk keluar BintanGo",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: dark3,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    //   return false;
    // }

    return true;
  }
}
