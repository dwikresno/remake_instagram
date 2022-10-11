// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls, avoid_unnecessary_containers

import 'package:dashed_circle/dashed_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_new/ui/feeds/VideoFeedPlayer.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  /// Variables
  AnimationController? animationController;
  Animation<double>? base;
  Animation<double>? gap;
  Animation<double>? reverse;
  ScrollController? scrollController;

  List<AnimationController>? listAnimationcontroller = [];
  List<Animation<double>>? listBase = [];
  List<Animation<double>>? listGap = [];
  List<Animation<double>>? listReverse = [];
  ScrollController? controllerMain;
  var listItem = [
    "https://images.unsplash.com/photo-1564564295391-7f24f26f568b",
    "https://images.unsplash.com/photo-1564564295391-7f24f26f568b",
    "https://images.unsplash.com/photo-1564564295391-7f24f26f568b",
    "https://images.unsplash.com/photo-1564564295391-7f24f26f568b",
    "https://images.unsplash.com/photo-1564564295391-7f24f26f568b",
    "https://images.unsplash.com/photo-1564564295391-7f24f26f568b",
    "https://images.unsplash.com/photo-1564564295391-7f24f26f568b",
    "https://images.unsplash.com/photo-1564564295391-7f24f26f568b",
    "https://images.unsplash.com/photo-1564564295391-7f24f26f568b",
  ];

  /// Init
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    controllerMain = ScrollController();
    listItem.asMap().forEach((index, value) {
      listAnimationcontroller!.add(
          AnimationController(vsync: this, duration: Duration(seconds: 3)));
      listBase!.add(CurvedAnimation(
          parent: listAnimationcontroller![index], curve: Curves.easeOut));
      listReverse!
          .add(Tween<double>(begin: 0.0, end: -1.0).animate(listBase![index]));
      listGap!.add(Tween<double>(begin: 0.0, end: 0.0).animate(listBase![index])
        ..addListener(() {
          if (mounted) setState(() {});
        }));
    });

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    base = CurvedAnimation(parent: animationController!, curve: Curves.easeOut);
    reverse = Tween<double>(begin: 0.0, end: -1.0).animate(base!);
    gap = Tween<double>(begin: 0.0, end: 0.0).animate(base!)
      ..addListener(() {
        if (mounted) setState(() {});
      });
  }

  /// Dispose
  @override
  void dispose() {
    listAnimationcontroller!.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Image.asset(
          "assets/png/logo-home.png",
          width: 100,
        ),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: SvgPicture.asset(
              "assets/svg/navbar/add-post.svg",
              width: 22,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: SvgPicture.asset(
              "assets/svg/navbar/activity.svg",
              width: 22,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: SvgPicture.asset(
              "assets/svg/navbar/messenger.svg",
              width: 24,
            ),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          InViewNotifierCustomScrollView(
            initialInViewIds: ['0'],
            isInViewPortCondition: (double deltaTop, double deltaBottom,
                double viewPortDimension) {
              return deltaTop < (0.5 * viewPortDimension) &&
                  deltaBottom > (0.5 * viewPortDimension);
            },
            controller: scrollController!,
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: widgetStory(),
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: 10, bottom: 50.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 50.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      "https://images.unsplash.com/photo-1564564295391-7f24f26f568b",
                                      fit: BoxFit.cover,
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    child: Text(
                                      'Naruto',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    child: Icon(Icons.more_vert),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 300.0,
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              child: LayoutBuilder(
                                builder: (BuildContext context,
                                    BoxConstraints constraints) {
                                  return InViewNotifierWidget(
                                    id: '$index',
                                    builder: (BuildContext context,
                                        bool isInView, Widget? child) {
                                      return VideoFeedPlayer(
                                          play: isInView,
                                          url:
                                              'https://media.istockphoto.com/id/1152765188/id/video/pengusaha-bekerja-di-kafe-saat-coffee-break.mp4?s=mp4-640x640-is&k=20&c=oAKpxgjTQ2ffW3OAOrl5kzaAoUtA_HOBqExt9xdw35Q=');
                                    },
                                  );
                                },
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: SvgPicture.asset(
                                      "assets/svg/reel/like.svg",
                                      width: 22,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: SvgPicture.asset(
                                      "assets/svg/reel/comment.svg",
                                      width: 22,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: SvgPicture.asset(
                                      "assets/svg/reel/share.svg",
                                      width: 22,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: 10,
                  ),
                ),
              ),
            ],
          ),
          IgnorePointer(
            ignoring: true,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                // height: 200.0,
                // color: Colors.redAccent.withOpacity(0.2),
                height: 1.0,
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget widgetStory() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Colors.grey[200]!,
          ),
        ),
      ),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 5),
        itemCount: listItem.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              Visibility(
                visible: index == 0,
                child: GestureDetector(
                  onTap: () {
                    gap = Tween<double>(begin: 3.0, end: 0.0).animate(base!)
                      ..addListener(() {
                        if (mounted) setState(() {});
                      });
                    animationController!.forward().whenComplete(() {
                      animationController!.reset();
                      gap = Tween<double>(begin: 0.0, end: 0.0).animate(base!)
                        ..addListener(() {
                          if (mounted) setState(() {});
                        });
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                    height: 90,
                    width: 80,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              alignment: Alignment.center,
                              child: RotationTransition(
                                turns: base!,
                                child: DashedCircle(
                                  gapSize: gap!.value,
                                  dashes: 20,
                                  color: Colors.white,
                                  child: RotationTransition(
                                    turns: reverse!,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: CircleAvatar(
                                        radius: 80.0,
                                        backgroundImage: NetworkImage(
                                            "https://images.unsplash.com/photo-1564564295391-7f24f26f568b"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.blue,
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            'Your Story',
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  listGap![index] = Tween<double>(begin: 3.0, end: 0.0)
                      .animate(listBase![index])
                    ..addListener(() {
                      if (mounted) setState(() {});
                    });
                  listAnimationcontroller![index].forward().whenComplete(() {
                    listAnimationcontroller![index].reset();
                    listGap![index] = Tween<double>(begin: 0.0, end: 0.0)
                        .animate(listBase![index])
                      ..addListener(() {
                        if (mounted) setState(() {});
                      });
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                  height: 90,
                  width: 80,
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        alignment: Alignment.center,
                        child: RotationTransition(
                          turns: listBase![index],
                          child: DashedCircle(
                            gapSize: listGap![index].value,
                            dashes: 20,
                            color: Color(0XFFED4634),
                            child: RotationTransition(
                              turns: listReverse![index],
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CircleAvatar(
                                  radius: 80.0,
                                  backgroundImage: NetworkImage(
                                      "https://images.unsplash.com/photo-1564564295391-7f24f26f568b"),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          'OnePunchMan',
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
