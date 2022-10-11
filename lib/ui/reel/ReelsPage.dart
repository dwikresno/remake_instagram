// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_new/ui/reel/ReelVideoPlayer.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:video_player/video_player.dart';

class ReelsPage extends StatefulWidget {
  ReelsPage({Key? key}) : super(key: key);

  @override
  _ReelsPageState createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  List<VideoPlayerController>? listVideoController;
  var listVideo = [
    "https://assets.mixkit.co/videos/preview/mixkit-father-and-his-little-daughter-eating-marshmallows-in-nature-39765-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-little-daughter-eating-a-marshmallow-in-nature-39764-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-under-a-peripheral-road-with-two-avenues-on-the-sides-34560-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-very-excited-little-girl-opening-a-christmas-gift-with-her-39744-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-young-mother-with-her-little-daughter-decorating-a-christmas-tree-39745-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-father-and-mother-decorating-a-christmas-tree-39746-large.mp4",
  ];

  PreloadPageController? _controller;
  int current = 0;
  bool isOnPageTurning = false;

  void scrollListener() {
    if (isOnPageTurning &&
        _controller!.page == _controller!.page!.roundToDouble()) {
      setState(() {
        current = _controller!.page!.toInt();
        isOnPageTurning = false;
      });
    } else if (!isOnPageTurning && current.toDouble() != _controller!.page) {
      if ((current.toDouble() - _controller!.page!).abs() > 0.1) {
        setState(() {
          isOnPageTurning = true;
        });
      }
    }
  }

  // List<ArExplore>? arExplore = [];
  var isLast = false;
  var page = 1;
  var pageSize = 5;
  var isCommentOpened = false;

  @override
  void initState() {
    // setFutureData();
    _controller = PreloadPageController();
    _controller!.addListener(scrollListener);
    super.initState();
  }

  // setFutureData() {
  //   pExplore!.getExplore(page: 1, draw: pageSize).then((value) {
  //     setState(() {
  //       arExplore?.addAll(value.arExplore!);
  //       page = page + 1;
  //     });
  //   });
  // }

  // loadMore() {
  //   if (!isLast) {
  //     pExplore!.getExplore(page: page, draw: pageSize).then((value) {
  //       if (value.arExplore!.length < pageSize) {
  //         arExplore!.addAll(value.arExplore!);
  //         setState(() {
  //           isLast = true;
  //         });
  //       } else {
  //         arExplore!.addAll(value.arExplore!);
  //         setState(() {
  //           page = page + 1;
  //         });
  //       }
  //     });
  //   }
  // }

  parentFunction(isCommentOpenedTemp) {
    setState(() {
      isCommentOpened = isCommentOpenedTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size(0, 0),
        child: AppBar(
          backgroundColor: Colors.black,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      body: Stack(
        children: [
          Container(
            child: PreloadPageView.builder(
              controller: _controller,
              physics: isCommentOpened ? NeverScrollableScrollPhysics() : null,
              scrollDirection: Axis.vertical,
              itemCount: listVideo.length,
              preloadPagesCount: 1,
              onPageChanged: (value) {
                // print("cari aku ${(value + 1)}");
                // if (value + 1 == arExplore!.length) {
                //   loadMore();
                // }
              },
              itemBuilder: (context, pageIndex) {
                return ReelVideoPlayer(
                    pageIndex: pageIndex,
                    currentPageIndex: current,
                    isPaused: isOnPageTurning,
                    url: listVideo[pageIndex],
                    function: parentFunction);
              },
            ),
          ),
          Positioned(
            top: 0,
            child: Visibility(
              visible: !isCommentOpened,
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    Text(
                      "Reels",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Spacer(),
                    SvgPicture.asset(
                      "assets/svg/reel/camera.svg",
                      width: 24,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
