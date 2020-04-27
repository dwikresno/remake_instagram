import 'package:flutter/material.dart';

class DetailPostPage extends StatefulWidget {
  final int value;

  const DetailPostPage({Key key, this.value}) : super(key: key);

  @override
  _DetailPostPageState createState() => _DetailPostPageState();
}

class _DetailPostPageState extends State<DetailPostPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Detail Post ${widget.value}'),
      ),
    );
  }
}
