import 'package:camera/camera.dart';
// import 'package:camera/new/src/common/camera_interface.dart';
import 'package:flutter/material.dart';
import 'package:remake_instagram/pages/story_page.dart';

import 'app.dart';

List<CameraDescription> cameras = [];

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }
  runApp(App(cameras: cameras));
}
