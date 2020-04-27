import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nested_navigators/nested_nav_item.dart';
import 'package:nested_navigators/nested_navigators.dart';
import 'package:remake_instagram/nested_nav_item_key.dart';
import 'package:remake_instagram/pages/explore/list_explore_image_page.dart';
import 'package:remake_instagram/pages/tab_menu/home_page.dart';
import 'package:remake_instagram/routes.dart';
// import 'package:nested_navigators_example/nested_nav_item_key.dart';
// import 'package:nested_navigators_example/routes.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return NestedNavigators(
      initialNavigatorKey: NestedNavItemKey.home,
      items: {
        NestedNavItemKey.home: NestedNavigatorItem(
          initialRoute: Routes.home,
          icon: FontAwesomeIcons.home,
          text: "",
        ),
        NestedNavItemKey.explore: NestedNavigatorItem(
          initialRoute: Routes.explore,
          icon: FontAwesomeIcons.search,
          text: "",
        ),
        NestedNavItemKey.add_post: NestedNavigatorItem(
          initialRoute: Routes.explore,
          icon: FontAwesomeIcons.plusSquare,
          text: "add_post",
        ),
        NestedNavItemKey.activity: NestedNavigatorItem(
          initialRoute: Routes.activity,
          icon: FontAwesomeIcons.heart,
          text: "",
        ),
        NestedNavItemKey.profile: NestedNavigatorItem(
          initialRoute: Routes.profile,
          icon: FontAwesomeIcons.user,
          text: "",
        ),
        // NestedNavItemKey.green: NestedNavigatorItem(
        //   initialRoute: Routes.green,
        //   icon: Icons.perm_identity,
        //   text: "",
        // ),
      },
      clearStackAfterTapOnCurrentTab: false,
      // clearStackAfterTapOnCurrentTab: true,
      generateRoute: Routes.generateRoute,
      // drawer: (items, selectedItemKey, selectNavigator) => Drawer(
      //   child: ListView(
      //     children: _buildDrawersItems(items, selectedItemKey, selectNavigator),
      //   ),
      // ),
      // endDrawer: (items, selectedItemKey, selectNavigator) => Drawer(
      //   child: ListView(
      //     children: _buildDrawersItems(items, selectedItemKey, selectNavigator),
      //   ),
      // ),
      buildBottomNavigationItem: (key, item, selected) {
        // index[i] = selected.toString();
        // i++;
        // if (i == 2) {
        //   i = 0;
        // }
        // print(i);
        print("${item.text} $selected");
        if (item.text == 'add_post' && selected == true) {
          Navigator.of(context).pushNamed(
            Routes.detail_post,
            arguments: 1,
          );
        }
        return BottomNavigationBarItem(
          icon: Icon(
            item.icon,
            color: Colors.black87,
          ),
          title: Text(
            selected.toString(),
            style: TextStyle(fontSize: 0),
          ),
          activeIcon: Icon(
            item.icon,
            color: Colors.black,
          ),
        );
      },

      bottomNavigationBarTheme: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
      ),
      // selected:0,
    );
  }

  List<ListTile> _buildDrawersItems(
    Map<NestedNavItemKey, NestedNavigatorItem> items,
    NestedNavItemKey selectedItemKey,
    Function(NestedNavItemKey) selectNavigator,
  ) {
    return items.entries
        .map((entry) => ListTile(
              title: Text(
                entry.value.text,
                style: TextStyle(
                  color: entry.key == selectedItemKey ? Colors.blue : null,
                ),
              ),
              trailing: Icon(
                entry.value.icon,
                color: entry.key == selectedItemKey ? Colors.blue : null,
              ),
              onTap: () => selectNavigator(entry.key),
            ))
        .toList();
  }
}
