import 'package:flutter/material.dart';
import 'package:remake_instagram/app.dart';
import 'package:remake_instagram/routes.dart';

class ListExploreImagePage extends StatefulWidget {
  final int value;

  const ListExploreImagePage({Key key, this.value}) : super(key: key);

  @override
  _ListExploreImagePageState createState() => _ListExploreImagePageState();
}

class _ListExploreImagePageState extends State<ListExploreImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body:ListView.builder(
          // padding: const EdgeInsets.all(8),
          itemCount: 100,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  Routes.detail_post,
                  arguments: index,
                );
              },
              child: Container(
                height: 100,
                color: Colors.amber,
                child: Center(
                  child: Text('LIst Detai Post ${widget.value}'),
                ),
              ),
            );
          }),
    );
  }
}
