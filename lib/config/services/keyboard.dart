import 'package:flutter/material.dart';

class Keyboard {
  static void close(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  // static void open(BuildContext context) {
  //   FocusScopeNode currentFocus = FocusScope.of(context);
  //   if (currentFocus.hasPrimaryFocus) {
  //     currentFocus.requestFocus();
  //   }
  // }
}
