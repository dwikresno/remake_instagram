import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:nested_navigators/nested_nav_bloc.dart';
import 'package:nested_navigators/nested_nav_bloc_provider.dart';
import 'package:remake_instagram/nested_nav_item_key.dart';
import 'package:remake_instagram/pages/dm/dm_page.dart';
import 'package:remake_instagram/pages/root_page.dart';
import 'package:remake_instagram/pages/story_page.dart';
import 'package:remake_instagram/routes.dart';
// import 'package:nested_navigators_example/nested_nav_item_key.dart';
// import 'package:nested_navigators_example/pages/root_page.dart';
// import 'package:nested_navigators_example/routes.dart';

class App extends StatefulWidget {
  final List<CameraDescription> cameras;

  const App({Key key, this.cameras}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  final NestedNavigatorsBloc _bloc = NestedNavigatorsBloc<NestedNavItemKey>();
  PageController controller;

  @override
  void initState() {
    // print('aku di app');
    super.initState();
    controller = PageController(initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return NestedNavigatorsBlocProvider(
      bloc: _bloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          accentColor: Colors.grey,
        ),
        // title: 'Flutter Demo',
        home: PageView(
          // physics: new NeverScrollableScrollPhysics(),
          controller: controller,
          children: <Widget>[
            StoryPage(widget.cameras),
            RootPage(),
            DmPage(),
          ],
          pageSnapping: true,
        ),
        // initialRoute: Routes.home,
        onGenerateRoute: (routeSettings) => Routes.generateRoute(routeSettings),
      ),
    );
  }
}

//class App extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() => _AppState();
//}
//
//class _AppState extends State<App> {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      home: RootPage(),
//      onGenerateRoute: (routeSettings) => Routes.generateRoute(routeSettings),
//    );
//  }
//}
