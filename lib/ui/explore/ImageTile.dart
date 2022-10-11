import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  const ImageTile({
    Key? key,
    required this.index,
    required this.width,
    required this.height,
    this.isLong = false,
  }) : super(key: key);

  final int index;
  final int width;
  final int height;
  final bool isLong;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.network(
          'https://picsum.photos/$width/$height?random=$index',
          width: width.toDouble(),
          height: height.toDouble(),
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 5,
          right: 5,
          child: Visibility(
            visible: isLong,
            child: Image.network(
              'https://img.icons8.com/ios-filled/452/instagram-reel.png',
              color: Colors.white,
              width: 25,
              height: 25,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
