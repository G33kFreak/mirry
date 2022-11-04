import 'package:flutter/material.dart';
import 'package:mirry/src/widgets/app_icon_painter.dart';

class AnimatedAppIcon extends StatefulWidget {
  final double size;
  final bool isAnimating;

  const AnimatedAppIcon({
    Key? key,
    this.size = 192,
    this.isAnimating = false,
  }) : super(key: key);

  @override
  State<AnimatedAppIcon> createState() => _AnimatedAppIconState();
}

class _AnimatedAppIconState extends State<AnimatedAppIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<double> _animation;

  static const Duration _animationDuration = Duration(milliseconds: 800);

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addStatusListener(_animationStatusListener);

    if (widget.isAnimating) {
      _startAnimation();
    }
    super.initState();
  }

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animationController.reverse();
    } else if (status == AnimationStatus.dismissed && widget.isAnimating) {
      _animationController.forward();
    }
  }

  void _startAnimation() {
    _animationController.forward();
  }

  void _stopAnimation() {
    _animationController.stop();
    _animationController.animateTo(0);
  }

  @override
  void didUpdateWidget(covariant AnimatedAppIcon oldWidget) {
    if (oldWidget.isAnimating != widget.isAnimating) {
      if (widget.isAnimating) {
        _startAnimation();
      } else {
        _stopAnimation();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) => CustomPaint(
        size: Size(widget.size, widget.size),
        painter: AppIconPainter(opacityOfLoaderStroke: _animation.value),
      ),
    );
  }
}
