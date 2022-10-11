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
            context.read<TimeModuleBloc>().add(const InitTimeModule());
            return Container();
          }

          return Column(
            children: [
              Text(
                TimeModuleUtils.getFormattedDate(state.currentTime!),
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                TimeModuleUtils.getFormattedTime(state.currentTime!),
                style: Theme.of(context).textTheme.headline1,
              )
            ],
          );
        },
      ),
    );
  }
}
