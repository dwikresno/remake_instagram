import 'package:flutter/material.dart';

class ActivityPage extends StatefulWidget {
  ActivityPage({Key key}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Activity')
      ),
      body: ListView.builder(
          // padding: const EdgeInsets.all(8),
          itemCount: 100,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 100,
              color: Colors.amber,
              child: Center(
                child: Text('Post $index'),
              ),
            );
          }),
    );
  }
}
