import 'package:flutter/cupertino.dart';

class AppTheme {
  static const primaryColor = CupertinoColors.systemBlue;
  static const backgroundColor = CupertinoColors.systemBackground;
  static const cardColor = CupertinoColors.white;

  static CupertinoThemeData light = const CupertinoThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    barBackgroundColor: backgroundColor,
    textTheme: CupertinoTextThemeData(
      primaryColor: primaryColor,
    ),
  );
}
