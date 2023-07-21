import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyOrientation {
  final BuildContext context;
  MyOrientation(this.context);

  static void systemUiOverlayStyle() {
    setPortraitUp();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  static void get enableNavigationBar {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
  }

  static void get enableStatusBar {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
  }

  static void get enableSystemUI {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }

  static void get disableSystemUI {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
      // overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
  }

  static void systemNavigationBarMode(bool isLight) {
    enableSystemUI;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        //  statusBarColor: isLight ? Colors.white : Colors.black,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor:
            isLight ? const Color(0xffF6F6F6) : Colors.black,
        systemNavigationBarIconBrightness:
            isLight ? Brightness.dark : Brightness.light,
      ),
    );
  }

  static void setPortraitUp() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  static void setLandscape() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: []);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      //DeviceOrientation.portraitUp,
    ]);
  }
}
