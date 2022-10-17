import 'package:circular_progress_bar_with_lines/circular_progress_bar_with_lines.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mirry_client/src/modules/teeth_brusing_module/bloc/teeth_brushing_module_bloc.dart';
import 'package:mirry_client/src/modules/teeth_brusing_module/bloc/teeth_brushing_module_bloc_provider.dart';
import 'package:mirry_client/src/modules/teeth_brusing_module/utils/brushing_state.dart';

class BrushingTeethView extends StatelessWidget {
  const BrushingTeethView({Key? key}) : super(key: key);

  Widget _getWidgetByBrushingState(BrushingState state) {
    if (state is InProgressState) {
      return Lottie.asset(
        'assets/animations/teeth_brushing.json',
        width: 200,
      );
    } else if (state is PausedState) {
      return const Icon(
        Icons.pause_rounded,
        color: Colors.white,
        size: 100,
      );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return TeethBrushingModuleBlocProvider(
      child: BlocBuilder<TeethBrushingModuleBloc, TeethBrushingModuleState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
            child: state.brushingState is IdleState
                ? const SizedBox(height: 300, width: 300)
                : CircularProgressBarWithLines(
                    percent: state.progress.toDouble(),
                    linesColor: Colors.white,
                    centerWidgetBuilder: (context) => AnimatedSwitcher(
                      transitionBuilder: (child, animation) => ScaleTransition(
                        scale: animation,
                        child: child,
                      ),
                      duration: const Duration(milliseconds: 300),
                      child: _getWidgetByBrushingState(state.brushingState),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
