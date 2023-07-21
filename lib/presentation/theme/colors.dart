// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';

class ColorsLight {
  Color statusBarColor = Colors.white;
  Color systemNavigationBarColor = Colors.white;
  Color text = Colors.black;
  Color searchCanvas = Colors.black87;
  Color canvas = Colors.white;
  Color appbarbg = Colors.white;
  Color appBarShadow = const Color(0xffEAEAEA);
  Color appBarIcon = const Color(0xff1B1B1B);
  Color navigationBg = const Color(0xffFFFFFF);
  Color navigatActiveIcon = const Color(0xff3E9851);
  Color navigatUnactiveIcon = const Color(0xff384854);
  Color navigatActiveIconBg = const Color(0xffDBEDE0);
  Color switchBg = const Color(0xffD9D9D9);
  Color switchUnActiv = const Color(0xff364857);
  Color switchActiv = const Color(0xff15872E);
  Color inputFocus = Colors.black;
  Color inputEnable = const Color(0xff15872E);
  Color inputText = Colors.black;
//=======================================================================
  Color shimmerBg = Colors.grey.withOpacity(0.25);
  Color shimmerLine = Colors.grey.withOpacity(0.6);

  List<Color> rainBowColors = [
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.blue,
    Colors.green,
  ];

  // void get suffleRainBow => rainBowColors.shuffle();

  Color persent(double persentage) {
    final int div = 100 ~/ rainBowColors.length;
    final int index = (persentage-1) ~/ div;
    return rainBowColors[index];
  }

  Color get rainbow {
    // suffleRainBow;
    return rainBowColors[1];
  }
}

class ColorsDark extends ColorsLight {
  @override
  Color statusBarColor = Colors.black;
  @override
  Color systemNavigationBarColor = Colors.black;
  @override
  Color text = Colors.white;
  @override
  Color canvas = Colors.black;
  @override
  Color appbarbg = const Color.fromARGB(255, 24, 22, 22);
  @override
  Color appBarShadow = Colors.black;
  @override
  Color appBarIcon = Colors.white;
  @override
  Color navigationBg = Colors.black;
  @override
  Color navigatActiveIcon = const Color(0xff31643C);
  @override
  Color navigatUnactiveIcon = const Color(0xff3A4753);
  @override
  Color navigatActiveIconBg = const Color(0xff031508);
  @override
  Color inputFocus = Colors.white;
  @override
  Color inputEnable = const Color(0xff15872E);
  @override
  Color inputText = Colors.white;
  //=======================================================================
}
