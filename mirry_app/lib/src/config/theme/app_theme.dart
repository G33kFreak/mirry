import 'package:flutter/material.dart';
import 'package:mirry/src/config/theme/colors.dart';

class AppTheme {
  static ThemeData get defaultTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bgColor,
      );
}
