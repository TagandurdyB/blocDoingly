// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';

class ShadowsLight {
  List<BoxShadow> appBar = [
    const BoxShadow(offset: Offset(0, 1), blurRadius: 0.2, spreadRadius: 0.1)
  ];
  List<BoxShadow> all = [
    BoxShadow(color: Colors.grey[800]!, blurRadius: 10, spreadRadius: 0.5)
  ];

  List<BoxShadow> list = [
    const BoxShadow(
        color: Color.fromARGB(195, 229, 226, 226),
        offset: Offset(0, 3),
        blurRadius: 4,
        spreadRadius: 0.5)
  ];
  static List<BoxShadow> text = [
    const BoxShadow(
        color: Colors.black,
        offset: Offset(0, 3),
        blurRadius: 4,
        spreadRadius: 0.5)
  ];
}

class ShadowsDark extends ShadowsLight {
  @override
  List<BoxShadow> appBar = [
    const BoxShadow(offset: Offset(0, 1), blurRadius: 0.2, spreadRadius: 0.1)
  ];
  @override
  List<BoxShadow> all = [
    BoxShadow(color: Colors.grey[600]!, blurRadius: 10, spreadRadius: 0.5)
  ];
}
