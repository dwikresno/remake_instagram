import 'package:flutter/material.dart';
import 'package:remake_instagram/pages/explore/list_explore_image_page.dart';
import 'package:remake_instagram/pages/home/detail_post.dart';
import 'package:remake_instagram/pages/tab_menu/acitivity_page.dart';
import 'package:remake_instagram/pages/tab_menu/explore_page.dart';
import 'package:remake_instagram/pages/tab_menu/home_page.dart';
import 'package:remake_instagram/pages/tab_menu/profile_page.dart';

import 'argument_keys.dart';
import 'pages/green_page.dart';

class Routes {
  Routes._();

  static const root = '/home';
  static const home = '/home';
  static const detail_post = '/detail_post';
  static const explore = '/explore';
  static const list_explore_image = '/list_explore_image';
  static const activity = '/activity';
  static const profile = '/profile';
  static const red = '/red';
  static const blue = '/blue';
  static const green = '/green';

  static MaterialPageRoute generateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (context) =>
          _buildPage(routeSettings.name, routeSettings.arguments),
    );
  }

  static Widget _buildPage(String name, Object arguments) {
    Map<String, dynamic> argumentsMap =
        arguments is Map<String, dynamic> ? arguments : Map();
    switch (name) {
      case home:
        return HomePage();
      case detail_post:
        return DetailPostPage(
          value: arguments ?? 0,
        );
      case explore:
        return ExplorePage();
      case list_explore_image:
        return ListExploreImagePage(
          value: arguments ?? 0,
        );
      case activity:
        return ActivityPage();
      case profile:
        return ProfilePage();
      case green:
        return GreenPage(
          value: argumentsMap[ArgumentKeys.value] ?? 0,
        );
      default:
        return Container();
    }
  }
}
