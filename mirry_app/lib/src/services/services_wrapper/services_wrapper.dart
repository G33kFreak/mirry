import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry/src/config/routes.dart';
import 'package:mirry/src/services/authentication/authentication_wrapper.dart';

class ServicesWrapper extends StatelessWidget {
  final AppRouter router;
  final Widget child;

  const ServicesWrapper({
    Key? key,
    required this.router,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        authenticationWrapper(router: router),
      ],
      child: child,
    );
  }
}
