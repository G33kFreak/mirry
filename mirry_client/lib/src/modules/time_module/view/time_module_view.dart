import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry_client/src/modules/time_module/bloc/time_module_bloc.dart';
import 'package:mirry_client/src/modules/time_module/bloc/time_module_bloc_provider.dart';
import 'package:mirry_client/src/modules/time_module/utils/time_module_utils.dart';

class TimeModuleView extends StatelessWidget {
  const TimeModuleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimeModuleBlocProvider(
      child: BlocBuilder<TimeModuleBloc, TimeModuleState>(
        builder: (context, state) {
          if (state.currentTime == null) {
            return Container();
          }

          return Column(
            children: [
              Text(
                TimeModuleUtils.getFormattedDate(state.currentTime!),
                style: Theme.of(context).textTheme.headline6,
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: child,
                ),
                child: Text(
                  TimeModuleUtils.getFormattedTime(state.currentTime!),
                  key: ValueKey<DateTime>(state.currentTime!),
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
