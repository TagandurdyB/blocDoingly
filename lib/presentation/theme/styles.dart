// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';

import 'shadows.dart';

class StylesLight {
  TextStyle appBar = const TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20);
  TextStyle avatar = const TextStyle(color: Colors.orange);
  TextStyle input = const TextStyle(color: Colors.black, fontSize: 14);

  TextStyle _site(double size) {
    return TextStyle(
        color: Colors.white,
        fontSize: size,
        fontWeight: FontWeight.bold,
        shadows: ShadowsLight.text);
  }

  TextStyle site(double size) => _site(size);
}

class StylesDark extends StylesLight {
  @override
  TextStyle appBar = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20);
  @override
  TextStyle input = const TextStyle(color: Colors.white, fontSize: 14);
}
