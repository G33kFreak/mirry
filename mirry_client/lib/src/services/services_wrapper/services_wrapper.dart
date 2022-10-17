import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry_client/src/services/user_recognition/bloc/user_recognition_bloc.dart';

class ServicesWrapper extends StatelessWidget {
  final Widget? child;

  const ServicesWrapper({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserRecognitionBloc, UserRecognitionState>(
      builder: (context, state) {
        return Scaffold(
          body: AnimatedSwitcher(
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation,
                child: child,
              ),
            ),
            duration: const Duration(milliseconds: 400),
            child: state.currentUser == null ? Container() : child,
          ),
        );
      },
    );
  }
}
