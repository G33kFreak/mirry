import 'package:flutter/material.dart';

class WeatherSubInfoItem extends StatelessWidget {
  final String title;
  final String value;

  const WeatherSubInfoItem({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title), Text(value)],
    );
  }
}
