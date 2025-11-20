import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppNavigator {
  static void pushReplacement(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (context) => page),
    );
  }

  static void pushAndRemove(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );
  }

  static void push(BuildContext context, Widget page) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => page));
  }
}
