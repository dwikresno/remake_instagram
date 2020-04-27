import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ExplorePage extends StatefulWidget {
  ExplorePage({Key key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:RefreshIndicator(
        onRefresh: () async {
          print('refresh');
        },
        child: new StaggeredGridView.countBuilder(
          crossAxisCount: 3,
          itemCount: 112,
          itemBuilder: (BuildContext context, int index) => new Container(
            color: Colors.green,
            child: new Center(
              child: Container(
                color: Colors.white,
                child: ((index + 1) == 10 || (index + 1) % 20 == 0) || index + 1 == 2
                    ? Text('video')
                    : index >= 27
                        ? (index + 3) % 10 == 0 && (index + 3) % 20 != 0 ? Text('story') : Text('gambar')
                        : Text('gambar'),
              ),
            ),
          ),
          staggeredTileBuilder: (int index) {
            return StaggeredTile.count(
                ((index + 1) == 10 || (index + 1) % 20 == 0) || index + 1 == 2
                    ? 2
                    : 1,
                ((index + 1) == 10 || (index + 1) % 20 == 0) || index + 1 == 2
                    ? 2
                    : index >= 27
                        ? (index + 3) % 10 == 0 && (index + 3) % 20 != 0 ? 2 : 1
                        : 1);
          },
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
        ),
      )
    );
  }
}