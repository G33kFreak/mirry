import 'package:flutter/material.dart';
import 'package:mirry_client/src/modules/todo_module/utils/animations.dart';

class TodoListItemTransition extends StatelessWidget {
  final Widget? child;
  final Animation<double> animation;

  const TodoListItemTransition({
    Key? key,
    this.child,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: curveFadeAnimation(animation),
      child: SizeTransition(
        sizeFactor: curveSizeAnimation(animation),
        axisAlignment: -1,
        child: child,
      ),
    );
  }
}
