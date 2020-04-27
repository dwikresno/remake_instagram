import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nested_navigators/nested_nav_bloc_provider.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:remake_instagram/argument_keys.dart';
import 'package:remake_instagram/data/listdata.dart';
import 'package:remake_instagram/data/liststory.dart';
import 'package:remake_instagram/nested_nav_item_key.dart';
import 'package:remake_instagram/routes.dart';
// import 'package:nested_navigators_example/nested_nav_item_key.dart';
// import 'package:nested_navigators_example/routes.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollControllerSingleChat;
  int pagingPost = 10;
  @override
  void initState() {
    _scrollControllerSingleChat = ScrollController();
    _scrollControllerSingleChat
        .addListener(_scrollControllerSingleChatListener);
    super.initState();
  }

  _scrollControllerSingleChatListener() {
    // print('au');
    if (_scrollControllerSingleChat.offset >=
            _scrollControllerSingleChat.position.maxScrollExtent &&
        !_scrollControllerSingleChat.position.outOfRange) {
      setState(() {
        print("reach the bottom");
        pagingPost = pagingPost + 10;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 1,
        leading: Container(
          padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
          child: FaIcon(
            FontAwesomeIcons.cameraRetro,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            child: FaIcon(
              FontAwesomeIcons.paperPlane,
              color: Colors.black,
            ),
          )
        ],
        title: Container(
          // padding: EdgeInsets.only(right: 100),
          child: Text(
            "Instagaram",
            style: TextStyle(
              fontFamily: 'Billabong',
              color: Colors.black,
              fontSize: 30,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          print('refresh');
        },
        child: SingleChildScrollView(
          controller: _scrollControllerSingleChat,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                ),
                margin: EdgeInsets.only(bottom: 5),
                height: 95,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    // padding: const EdgeInsets.all(8),
                    itemCount: story.length,
                    itemBuilder: (BuildContext context, int index) {
                      return index == 0
                          ? Row(
                              children: <Widget>[myStory(), friendStory(index)],
                            )
                          : friendStory(index);
                    }),
              ),
              ConstrainedBox(
                constraints: new BoxConstraints(
                  minHeight: 35.0,
                  maxHeight: MediaQuery.of(context).size.height * 10000,
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    // padding: const EdgeInsets.all(8),
                    itemCount:
                        pagingPost > data.length ? data.length : pagingPost,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(color: Colors.white),
                            height: 550,
                            child: NeuCard(
                              // margin: EdgeInsets.all(15),
                              // State of Neumorphic (may be convex, flat & emboss)
                              curveType: CurveType.concave,

                              // Elevation relative to parent. Main constituent of Neumorphism
                              bevel: 10,

                              // Specified decorations, like `BoxDecoration` but only limited
                              decoration: NeumorphicDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),

                              // Other arguments such as margin, padding etc. (Like `Container`)
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    height: 50,
                                    child: Row(
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: Image.asset(
                                            'assets/images/${data[index]['pp']}',
                                            height: 35.0,
                                            width: 35.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Center(
                                            child: Text(
                                              '${data[index]['name']}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: Icon(Icons.more_vert),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    // height: 500,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          'assets/images/${data[index]['image']}',
                                          // height: 35.0,
                                          // width: 35.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(bottom: 5, left: 10, top: 15),
                            // margin: EdgeInsets.all(5),
                            height: 45,
                            child: Row(
                              children: <Widget>[
                                NeuCard(
                                  height: 40,
                                  // width: 40,
                                  // margin: EdgeInsets.all(15),
                                  // State of Neumorphic (may be convex, flat & emboss)
                                  curveType: CurveType.concave,

                                  // Elevation relative to parent. Main constituent of Neumorphism
                                  bevel: 12,

                                  // Specified decorations, like `BoxDecoration` but only limited
                                  decoration: NeumorphicDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        FaIcon(FontAwesomeIcons.heart),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                              '${data[index]['likes']} Likes'),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      Routes.detail_post,
                                      arguments: index,
                                    );
                                  },
                                  child: NeuCard(
                                    margin: EdgeInsets.only(left: 10),
                                    height: 40,
                                    // width: 40,
                                    // margin: EdgeInsets.all(15),
                                    // State of Neumorphic (may be convex, flat & emboss)
                                    curveType: CurveType.concave,

                                    // Elevation relative to parent. Main constituent of Neumorphism
                                    bevel: 12,

                                    // Specified decorations, like `BoxDecoration` but only limited
                                    decoration: NeumorphicDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: <Widget>[
                                          FaIcon(FontAwesomeIcons.comment),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                                '${data[index]['comment_count']} Comments'),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showBottomModal();
                                  },
                                  child: NeuCard(
                                    margin: EdgeInsets.only(left: 10),
                                    height: 40,
                                    width: 40,
                                    // margin: EdgeInsets.all(15),
                                    // State of Neumorphic (may be convex, flat & emboss)
                                    curveType: CurveType.concave,

                                    // Elevation relative to parent. Main constituent of Neumorphism
                                    bevel: 12,

                                    // Specified decorations, like `BoxDecoration` but only limited
                                    decoration: NeumorphicDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          FaIcon(FontAwesomeIcons.paperPlane),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              margin:
                                  EdgeInsets.only(bottom: 30, left: 5, top: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                          '${data[index]['name']}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                          '${data[index]['caption']}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10, top: 5),
                                    child: Text(
                                      '${data[index]['time']}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey),
                                    ),
                                  )
                                ],
                              ))
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myStory() {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.5, 0.9],
                  colors: [
                    Color(0xFFd62976),
                    Color(0xFFfa7e1e),
                    Color(0xFFfeda75),
                  ],
                ),
              ),
              child: Container(
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                height: 20,
                width: 20,
                child: Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  height: 20,
                  width: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset(
                      'assets/images/main_pp.jpg',
                      height: 35.0,
                      width: 35.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Center(
                child: Text('Your Story'),
              ),
            )
          ],
        ),
        // Align(
        //   alignment: Alignment.center,
        //   child: Container(
        //     // margin: EdgeInsets.all(10),
        //     height: 45,
        //     width: 45,
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(50),
        //         color: Colors.white),
        //   ),
        // ),
      ],
    );
  }

  Widget friendStory(index) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.5, 0.9],
                  colors: [
                    story[index]['seen'] == 'n'
                        ? Color(0xFFd62976)
                        : Colors.grey.withOpacity(0.5),
                    story[index]['seen'] == 'n'
                        ? Color(0xFFfa7e1e)
                        : Colors.grey.withOpacity(0.5),
                    story[index]['seen'] == 'n'
                        ? Color(0xFFfeda75)
                        : Colors.grey.withOpacity(0.5),
                  ],
                ),
              ),
              child: Container(
                margin: EdgeInsets.all(story[index]['seen'] == 'y' ? 1 : 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                height: 20,
                width: 20,
                child: Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  height: 20,
                  width: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset(
                      'assets/images/${story[index]['pp']}',
                      height: 35.0,
                      width: 35.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Center(
                child: Text(
                  '${story[index]['name']}',
                  style: TextStyle(
                      color: story[index]['seen'] == 'n'
                          ? Colors.black
                          : Colors.grey),
                ),
              ),
            )
          ],
        ),
        // Align(
        //   alignment: Alignment.center,
        //   child: Container(
        //     // margin: EdgeInsets.all(10),
        //     height: 45,
        //     width: 45,
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(50),
        //         color: Colors.white),
        //   ),
        // ),
      ],
    );
  }

  void showBottomModal() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      useRootNavigator: true,
      isDismissible: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.of(context).pop();
          },
          child: FractionallySizedBox(
            heightFactor: 1,
            child: DraggableScrollableSheet(
              expand: true,
              initialChildSize: 0.7,
              // maxChildSize: 1,
              minChildSize: 0.6,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return SafeArea(
                  top: true,
                  minimum: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.03),
                  child: Scaffold(
                    primary: false,
                    appBar: AppBar(),
                    body: Container(
                      color: Colors.white,
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: 25,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(title: Text('Item $index'));
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
