import 'package:flutter/cupertino.dart';

class AppColors {
  static const primaryColor = Color(0xff3b82f6);
  static const backgroundColor = Color(0xffffffff);
  static const cardColor = Color(0xffffffff);

  static const textColor = Color(0xff000000);
  static const textColor2 = Color(0xff6b7280);
  static const textColor3 = Color(0xff9ca3af);
  static const textColor4 = Color(0xffd1d5db);
  static const textColor5 = Color(0xfff3f4f6);

  static const primaryColor1 = Color(0xffeff6ff);
  static const primaryColor2 = Color(0xffdbeafe);
  static const primaryColor3 = Color(0xffbfdbfe);
  static const primaryColor4 = Color(0xff93c5fd);
  static const primaryColor5 = Color(0xff3b82f6);
  static const primaryColor6 = Color(0xff2563eb);
  static const primaryColor7 = Color(0xff1d4ed8);
  static const primaryColor8 = Color(0xff1e40af);
  static const primaryColor9 = Color(0xff1e3a8a);

  static CupertinoThemeData light = const CupertinoThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    barBackgroundColor: backgroundColor,
    textTheme: CupertinoTextThemeData(
      primaryColor: primaryColor,
    ),
  );
}
