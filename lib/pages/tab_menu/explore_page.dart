import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:remake_instagram/data/listcategory.dart';
import 'package:remake_instagram/data/listdata.dart';
import 'package:remake_instagram/routes.dart';

class ExplorePage extends StatefulWidget {
  ExplorePage({Key key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
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
                backgroundColor: Colors.white,
                leading: Container(
                  padding: EdgeInsets.fromLTRB(18, 18, 0, 18),
                  child: FaIcon(
                    FontAwesomeIcons.search,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
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
              SliverStickyHeaderBuilder(
                builder: (context, state) {
                  return Container(
                    height: 50.0,
                    color: Colors.white,
                    // padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        // padding: const EdgeInsets.all(8),
                        itemCount: category.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                Routes.detail_post,
                                arguments: index,
                              );
                            },
                            child: NeuCard(
                              curveType: CurveType.concave,
                              bevel: 12,
                              decoration: NeumorphicDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              margin: EdgeInsets.all(7),
                              padding: EdgeInsets.only(left: 20, right: 20),
                              height: 8,
                              // width: 100,
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
                                                  FontAwesomeIcons.shoppingBag,
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
                    constraints: new BoxConstraints(
                      minHeight: 35.0,
                      maxHeight: MediaQuery.of(context).size.height * 10000,
                    ),
                    child: new StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      crossAxisCount: 3,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(
                              Routes.list_explore_image,
                              arguments: index,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            // color: Colors.green,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/${data[index]['image']}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder: (int index) {
                        return StaggeredTile.count(
                            ((index + 1) == 10 || (index + 1) % 20 == 0) ||
                                    index + 1 == 2
                                ? 2
                                : 1,
                            ((index + 1) == 10 || (index + 1) % 20 == 0) ||
                                    index + 1 == 2
                                ? 2
                                : index >= 27
                                    ? (index + 3) % 10 == 0 &&
                                            (index + 3) % 20 != 0
                                        ? 2
                                        : 1
                                    : 1);
                      },
                      mainAxisSpacing: 3.0,
                      crossAxisSpacing: 3.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
