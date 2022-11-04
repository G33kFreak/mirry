import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mirry/src/config/theme/colors.dart';

class AppTheme {
  static ThemeData get defaultTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bgColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: bgColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: bgColor,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
        ),
      );
}
