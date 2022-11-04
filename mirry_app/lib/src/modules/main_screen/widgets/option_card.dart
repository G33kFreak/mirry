import 'package:flutter/material.dart';
import 'package:mirry/src/config/theme/colors.dart';

class OptionCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final void Function() onTap;

  const OptionCard({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Ink(
        height: 144,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: accentDark,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [BoxShadow(blurRadius: 8)],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue, size: 48),
            Expanded(
              child: VerticalDivider(
                width: 2,
                color: Colors.white.withOpacity(.25),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Colors.white.withOpacity(.35)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
