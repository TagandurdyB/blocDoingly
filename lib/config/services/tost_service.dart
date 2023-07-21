import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TostService {
  static get soon => Fluttertoast.showToast(
      msg: "Under development!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);

  static get login => Fluttertoast.showToast(
      msg: "Agza boluň!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);

  static get wilPop => Fluttertoast.showToast(
      msg: "Çykmak üçin ýene bir gezek basyň!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[200],
      textColor: Colors.black,
      fontSize: 16.0);

  static message(String msg, bool isOk) => Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isOk ? Colors.green : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
