import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry/src/utils/loading_state.dart';

class ErrorManager<Bloc extends StateStreamable<State>, State, ErrorType>
    extends StatelessWidget {
  final Widget child;
  final void Function(ErrorType) onError;

  const ErrorManager({
    Key? key,
    required this.child,
    required this.onError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<Bloc, State>(
      listener: (context, dynamic state) {
        if (state.loadingState is FailedState) {
          onError(state.error);
        }
      },
      child: child,
    );
  }
}
