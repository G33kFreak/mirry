import 'package:flutter/material.dart';
import 'package:mirry/src/widgets/animated_app_icon.dart';

class LoadingScreenView extends StatelessWidget {
  static const heroTag = 'loadingLogo';

  const LoadingScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Hero(
          tag: heroTag,
          child: AnimatedAppIcon(
            isAnimating: true,
          ),
        ),
      ),
    );
  }
}
