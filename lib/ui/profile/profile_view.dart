// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_new/viewmodel/theme_view_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ImagePicker _picker = ImagePicker();
  final ThemeViewModel themeViewModel = Get.put(ThemeViewModel());
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String username = "dwikresno11";
  String fullname = "Fransiscus Xaverius Dwi Kresno";
  String category = "Education";
  String description = "Software Engineer";
  String url = "linktr.ee/dwikresno11";
  String post = "100";
  String followers = "1.5M";
  String following = "321";
  List<XFile> listPost = [];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeViewModel>(builder: (tx) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                username,
              ),
              SizedBox(width: 5),
              Icon(
                Icons.keyboard_arrow_down_rounded,
              ),
              SizedBox(width: 2),
              Icon(
                Icons.circle,
                color: Colors.red,
                size: 10,
              )
            ],
          ),
          actions: [
            SvgPicture.asset(
              "assets/svg/navbar/add-post.svg",
              width: 22,
              color: tx.themeTextColor,
            ),
            SizedBox(width: 10),
            IconButton(
              icon: Icon(
                Icons.menu_rounded,
                color: tx.themeTextColor,
                size: 32,
              ),
              onPressed: () {
                _scaffoldKey.currentState!.openEndDrawer();
              },
            ),
            SizedBox(width: 20),
          ],
        ),
        endDrawer: Drawer(
          width: MediaQuery.of(context).size.width / 1.7,
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 15,
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog<String>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Change Theme Color'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ColorPicker(
                              pickerColor: tx.themeColor,
                              onColorChanged: (color) {
                                tx.changeThemeColor(color);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Change Theme Color",
                          ),
                        ),
                        Container(
                          height: 15,
                          width: 40,
                          color: tx.themeColor,
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog<String>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Chnage Theme Color'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ColorPicker(
                              pickerColor: tx.themeTextColor,
                              onColorChanged: (color) {
                                tx.changeThemeTextColor(color);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Change Theme Text Color",
                          ),
                        ),
                        Container(
                          height: 15,
                          width: 40,
                          color: tx.themeColor,
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    themeViewModel.changeNavbar();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Change Navbar",
                          ),
                        ),
                        Container(
                          height: 15,
                          width: 40,
                          color: tx.themeColor,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: GetBuilder<ThemeViewModel>(builder: (tx) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          tx.imagePP == null
                              ? CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                      "https://picsum.photos/500/500?random=1"))
                              : CircleAvatar(
                                  radius: 40,
                                  backgroundImage: FileImage(
                                    File(tx.imagePP!.path),
                                  ),
                                ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  post,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  "Posts",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  followers,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  "Followers",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  following,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  "Following",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        fullname,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        category,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: tx.themeTextColor.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        description,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      Row(
                        children: [
                          Transform.rotate(
                            angle: 2.2,
                            child: Icon(
                              Icons.link,
                              size: 20,
                            ),
                          ),
                          Text(
                            url,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: tx.themeColor.withOpacity(0.9),
                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            BoxShadow(color: Colors.grey),
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              "Profiessional Dashboard",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "100K accounts reached in the last 30 days.",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: tx.themeTextColor.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showModalForm(tx);
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: tx.themeColor.withOpacity(0.9),
                                  // ignore: prefer_const_literals_to_create_immutables
                                  boxShadow: [
                                    BoxShadow(color: Colors.grey),
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    "Edit profile",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: tx.themeColor.withOpacity(0.9),
                                // ignore: prefer_const_literals_to_create_immutables
                                boxShadow: [
                                  BoxShadow(color: Colors.grey),
                                ],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  "Share profile",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1.0,
                              color: tx.themeTextColor,
                            ),
                          ),
                        ),
                        child: SvgPicture.asset(
                          "assets/svg/grid.svg",
                          width: 22,
                          color: tx.themeTextColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 5),
                        child: SvgPicture.asset(
                          "assets/svg/navbar/reels-off.svg",
                          width: 22,
                          color: tx.themeTextColor.withOpacity(0.7),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 5),
                        child: SvgPicture.asset(
                          "assets/svg/tag.svg",
                          width: 22,
                          color: tx.themeTextColor.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: listPost.isNotEmpty
                      ? GridView.builder(
                          padding: EdgeInsets.only(top: 2, bottom: 40),
                          shrinkWrap: true,
                          // physics: BouncingScrollPhysics(
                          //     parent: AlwaysScrollableScrollPhysics()),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                          ),
                          itemCount: listPost.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Image.file(
                              File(listPost.elementAt(index).path),
                              fit: BoxFit.cover,
                            );
                          },
                        )
                      : Center(
                          child: GestureDetector(
                            onTap: () async {
                              final List<XFile>? images =
                                  await _picker.pickMultiImage();
                              if (images!.isNotEmpty) {
                                setState(() {
                                  listPost.addAll(images);
                                });
                              }
                            },
                            child: Icon(
                              Icons.add_box_outlined,
                              size: 40,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          );
        }),
      );
    });
  }

  showModalForm(ThemeViewModel tx) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
              ),
              // You can wrap this Column with Padding of 8.0 for better design
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () async {
                        final XFile? images = await _picker.pickImage(
                            source: ImageSource.gallery);
                        if (images != null) {
                          tx.updateImagePP(images);
                        }
                      },
                      child: tx.imagePP == null
                          ? CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                  "https://picsum.photos/500/500?random=1"))
                          : CircleAvatar(
                              radius: 40,
                              backgroundImage: FileImage(
                                File(tx.imagePP!.path),
                              ),
                            ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text("Change Profile Picture"),
                  ),
                  SizedBox(height: 10),
                  Text("Username"),
                  SizedBox(height: 5),
                  TextFormField(
                    initialValue: username,
                    onChanged: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Text("Post"),
                  SizedBox(height: 5),
                  TextFormField(
                    initialValue: post,
                    onChanged: (value) {
                      setState(() {
                        post = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Text("Follower"),
                  SizedBox(height: 5),
                  TextFormField(
                    initialValue: followers,
                    onChanged: (value) {
                      setState(() {
                        followers = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Text("Following"),
                  SizedBox(height: 5),
                  TextFormField(
                    initialValue: following,
                    onChanged: (value) {
                      setState(() {
                        following = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Text("Fullname"),
                  SizedBox(height: 5),
                  TextFormField(
                    initialValue: fullname,
                    onChanged: (value) {
                      setState(() {
                        fullname = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Text("Category"),
                  SizedBox(height: 5),
                  TextFormField(
                    initialValue: category,
                    onChanged: (value) {
                      setState(() {
                        category = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Text("Description"),
                  SizedBox(height: 5),
                  TextFormField(
                    scrollPadding: EdgeInsets.symmetric(vertical: 5),
                    maxLines: 5,
                    initialValue: description,
                    onChanged: (value) {
                      setState(() {
                        description = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Text("Link"),
                  SizedBox(height: 5),
                  TextFormField(
                    initialValue: url,
                    onChanged: (value) {
                      setState(() {
                        url = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Wrap(
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Save"),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
