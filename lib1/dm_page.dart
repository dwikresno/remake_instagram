import 'package:flutter/material.dart';

class DmPage extends StatefulWidget {
  DmPage({Key key}) : super(key: key);

  @override
  _DmPageState createState() => _DmPageState();
}

class _DmPageState extends State<DmPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('DM'),
      ),
    );
  }
}
