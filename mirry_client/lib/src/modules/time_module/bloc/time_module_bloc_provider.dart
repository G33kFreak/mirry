import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry_client/src/modules/time_module/bloc/time_module_bloc.dart';

class TimeModuleBlocProvider extends StatelessWidget {
  final Widget child;

  const TimeModuleBlocProvider({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimeModuleBloc(),
      child: child,
    );
  }
}
