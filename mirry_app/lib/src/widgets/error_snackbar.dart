import 'package:flutter/material.dart';
import 'package:mirry/src/config/theme/colors.dart';

void showErrorSnackbar(
  BuildContext context, {
  required String errorText,
}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          errorText,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        backgroundColor: accentDark,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(50),
        elevation: 30,
      ),
    );
