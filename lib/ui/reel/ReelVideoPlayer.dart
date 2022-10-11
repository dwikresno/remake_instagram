import 'dart:async';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

class ReelVideoPlayer extends StatefulWidget {
  ReelVideoPlayer({
    this.pageIndex,
    this.currentPageIndex,
    this.isPaused,
    this.function,
    @required this.url,
  });

  final int? pageIndex;
  final int? currentPageIndex;
  final bool? isPaused;
  final String? url;
  final Function? function;

  @override
  _ReelVideoPlayerState createState() => _ReelVideoPlayerState();
}

class _ReelVideoPlayerState extends State<ReelVideoPlayer>
    with TickerProviderStateMixin {
  VideoPlayerController? videoPlayerController;
  bool initialized = false;

  var selected1 = true;
  var selected2 = false;
  var isMuted = false;
  var visibleMute = false;
  var isCommentOpened = false;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.url!)
      ..initialize().then((_) {
        setState(() {
          videoPlayerController!.setLooping(true);
          initialized = true;
        });
      });
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (mounted)
        setState(() {
          selected1 = !selected1;
          selected2 = !selected2;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pageIndex == widget.currentPageIndex && initialized) {
      videoPlayerController!.play();
    } else {
      videoPlayerController!.pause();
    }

    var data = MediaQuery.of(context);

    // subtracted status bar and AppBar height from total height
    double height = data.size.height - kToolbarHeight;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: AnimatedContainer(
                  duration: new Duration(milliseconds: 300),
                  curve: Curves.fastOutSlowIn,
                  width: isCommentOpened
                      ? MediaQuery.of(context).size.width * 0.3
                      : MediaQuery.of(context).size.width,
                  height: isCommentOpened ? height * 0.3 : height,
                  color: Colors.black,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      videoPlayerController!.value.isInitialized
                          ? FittedBox(
                              fit: BoxFit.cover,
                              child: SizedBox(
                                width: isCommentOpened
                                    ? videoPlayerController!.value.size.width *
                                        0.3
                                    : videoPlayerController!.value.size.width,
                                height: isCommentOpened
                                    ? videoPlayerController!.value.size.height *
                                        0.3
                                    : videoPlayerController!.value.size.height,
                                child: AspectRatio(
                                  aspectRatio:
                                      videoPlayerController!.value.aspectRatio,
                                  child: VideoPlayer(videoPlayerController!),
                                ),
                              ),
                            )
                          : Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 20,
                                          horizontal: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 20,
                                          horizontal: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            visibleMute = true;
                          });
                          if (isMuted) {
                            print("pause");
                            videoPlayerController?.setVolume(1.0);
                            setState(() {
                              isMuted = false;
                            });
                          } else {
                            print("unpause");
                            videoPlayerController?.setVolume(0.0);
                            setState(() {
                              isMuted = true;
                            });
                          }
                          Timer(Duration(seconds: 1), () {
                            print("Yeah, this line is printed after 3 seconds");
                            setState(() {
                              visibleMute = false;
                            });
                          });
                          //
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: AnimatedOpacity(
                            // If the widget is visible, animate to 0.0 (invisible).
                            // If the widget is hidden, animate to 1.0 (fully visible).
                            opacity: visibleMute ? 1.0 : 0.0,
                            duration:
                                Duration(milliseconds: visibleMute ? 100 : 500),
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(50)),
                                child: Icon(
                                  isMuted ? Icons.volume_off : Icons.volume_up,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Visibility(
                          visible: !isCommentOpened,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: Container(
                              // height: 50,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: ExtendedImage.network(
                                          'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
                                          width: 25,
                                          height: 25,
                                          fit: BoxFit.cover,
                                          cache: true,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(50.0),
                                          ),
                                          //cancelToken: cancellationToken,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                        child: Text(
                                          "Zeus",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          height: 4,
                                          width: 4,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                        child: Text(
                                          "Follow",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    child: Text(
                                      "Traveling with my son... more",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    height: 15,
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              AnimatedContainer(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 2),
                                                width: 2,
                                                height: selected1 ? 12.0 : 6.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    20,
                                                  ),
                                                ),
                                                duration:
                                                    const Duration(seconds: 1),
                                                curve: Curves.fastOutSlowIn,
                                              ),
                                              AnimatedContainer(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 2),
                                                width: 2,
                                                height: selected2 ? 12.0 : 6.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    20,
                                                  ),
                                                ),
                                                duration:
                                                    const Duration(seconds: 1),
                                                curve: Curves.fastOutSlowIn,
                                              ),
                                              AnimatedContainer(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 2),
                                                width: 2,
                                                height: selected1 ? 12.0 : 6.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    20,
                                                  ),
                                                ),
                                                duration:
                                                    const Duration(seconds: 1),
                                                curve: Curves.fastOutSlowIn,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          child: Text(
                                            "My Life Be Like",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            height: 4,
                                            width: 4,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          child: Text(
                                            "Original Sound",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Visibility(
                          visible: !isCommentOpened,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 20,
                            ),
                            width: 40,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: SvgPicture.asset(
                                          "assets/svg/reel/like.svg",
                                          width: 24,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "12.2K",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          widget.function!(!isCommentOpened);
                                          setState(() {
                                            isCommentOpened = !isCommentOpened;
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          child: SvgPicture.asset(
                                            "assets/svg/reel/comment.svg",
                                            width: 24,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "1k",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 18,
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/svg/reel/share.svg",
                                    width: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                  child: Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 0,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: ExtendedImage.network(
                                      'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.cover,
                                      cache: true,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50.0),
                                      ),
                                      //cancelToken: cancellationToken,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: isCommentOpened,
                child: GestureDetector(
                  onTap: () {
                    widget.function!(!isCommentOpened);
                    setState(() {
                      isCommentOpened = !isCommentOpened;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: isCommentOpened ? height * 0.3 : height,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
          AnimatedContainer(
            duration: new Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            height: isCommentOpened ? height * 0.7 : 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back,
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Text(
                              "Comments",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: SvgPicture.asset(
                            "assets/svg/reel/share.svg",
                            width: 24,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: ListTile(
                              contentPadding: EdgeInsets.all(0),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://images.unsplash.com/photo-1504593811423-6dd665756598?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"),
                              ),
                              title: RichText(
                                text: TextSpan(
                                  text: 'Lorem Ipsum ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  children: const <TextSpan>[
                                    TextSpan(
                                      text:
                                          'is simply dummy text of the printing and typesetting industry!',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              subtitle: Text(
                                "2w",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 0.5,
                            thickness: 0.1,
                            color: Colors.black,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 20,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                contentPadding: EdgeInsets.all(0),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80"),
                                ),
                                title: RichText(
                                  text: TextSpan(
                                    text: 'Lorem Ipsum ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    children: const <TextSpan>[
                                      TextSpan(
                                        text:
                                            'is simply dummy text of the printing and typesetting industry!',
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                subtitle: Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          right: 5,
                                        ),
                                        child: Text(
                                          "2w",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          right: 5,
                                        ),
                                        child: Text(
                                          index == 0
                                              ? ""
                                              : "${index * 3} likes",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          right: 5,
                                        ),
                                        child: Text(
                                          "Reply",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                trailing: Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/svg/reel/like.svg",
                                    width: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    videoPlayerController!.dispose();
  }
}
