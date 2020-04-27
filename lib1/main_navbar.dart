import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:remake_instagram/explore_page.dart';
import 'package:remake_instagram/take_pic_page.dart';

class MainNavBar extends StatefulWidget {
  MainNavBar({Key key}) : super(key: key);

  @override
  _MainNavBarState createState() => _MainNavBarState();
}

class _MainNavBarState extends State<MainNavBar> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    // _bottomNavigationKey.currentState=1;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const color1 = const Color(0xff4f5bd5);
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        // buttonBackgroundColor: Colors.green,
        backgroundColor: Colors.transparent,
        color: Colors.white,
        index: _page,
        key: _bottomNavigationKey,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.search, size: 30),
          Icon(Icons.add_box, size: 30),
          Icon(Icons.favorite_border, size: 30),
          Icon(Icons.person_pin, size: 30),
        ],
        onTap: (index) {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TakePicPage()),
            ).then((val) {
              // _page.
              setState(() {});
            });
          } else {
            setState(() {
              _page = index;
            });
          }
        },
      ),
      body: layoutBody(),
    );
  }

  Widget layoutBody() {
    Widget child;
    switch (_page.toString()) {
      case '0':
        child = Container();
        break;
      case '1':
        child = ExplorePage();
        break;
      case '2':
        child = Container(
          color: Colors.black,
        );
        break;
      case '3':
        child = Container();
        break;
      case '4':
        child = Container();
        break;
      default:
        print('It\'s weekend');
    }
    return child;
  }
}
