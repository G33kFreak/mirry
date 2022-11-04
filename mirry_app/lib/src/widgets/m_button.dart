import 'package:flutter/material.dart';
import 'package:mirry/src/config/theme/colors.dart';

class MButton extends StatelessWidget {
  final bool isBlocked;
  final String title;
  final void Function() onTap;
  final double width;

  const MButton({
    Key? key,
    this.isBlocked = false,
    required this.title,
    required this.onTap,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: SizedBox(
        key: ValueKey(isBlocked),
        height: 40,
        width: width,
        child: IgnorePointer(
          ignoring: isBlocked,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: isBlocked ? accentDark : Colors.blue,
            ),
            child: Text(title),
          ),
        ),
      ),
    );
  }
}
