import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Username')
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
