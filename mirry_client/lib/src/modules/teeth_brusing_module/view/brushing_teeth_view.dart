import 'package:circular_progress_bar_with_lines/circular_progress_bar_with_lines.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mirry_client/src/modules/teeth_brusing_module/bloc/teeth_brushing_module_bloc.dart';
import 'package:mirry_client/src/modules/teeth_brusing_module/bloc/teeth_brushing_module_bloc_provider.dart';
import 'package:mirry_client/src/modules/teeth_brusing_module/utils/brushing_state.dart';

class BrushingTeethView extends StatelessWidget {
  const BrushingTeethView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TeethBrushingModuleBlocProvider(
      child: BlocBuilder<TeethBrushingModuleBloc, TeethBrushingModuleState>(
        builder: (context, state) {
          return CircularProgressBarWithLines(
            percent: state.progress.toDouble(),
            linesColor: Colors.white,
            centerWidgetBuilder: (context) => AnimatedSwitcher(
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: child,
              ),
              duration: const Duration(milliseconds: 300),
              child: state.brushingState is InProgressState
                  ? Lottie.asset(
                      'assets/animations/teeth_brushing.json',
                      width: 200,
                    )
                  : OutlinedButton(
                      onPressed: () => context
                          .read<TeethBrushingModuleBloc>()
                          .add(const BrushingStateChanged(InProgressState())),
                      child: Text('test'),
                    ),
            ),
          );
        },
      ),
    );
  }
}
