import 'dart:async';

import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'time_module_event.dart';
part 'time_module_state.dart';
part 'time_module_bloc.g.dart';

class TimeModuleBloc extends Bloc<TimeModuleEvent, TimeModuleState> {
  late Timer _updateTimer;

  TimeModuleBloc() : super(const TimeModuleState()) {
    on<InitTimeModule>(_onInitTimeModule);
    on<UpdateTime>(_onUpdateTime);
  }

  void _timerUpdater(Timer timer) {
    final now = DateTime.now();

    if (now.minute != state.currentTime?.minute) {
      add(UpdateTime(newTime: now));
    }
  }

  void _onInitTimeModule(
    InitTimeModule event,
    Emitter<TimeModuleState> emit,
  ) {
    final currentTime = DateTime.now();
    emit(state.copyWith(currentTime: currentTime));
    _updateTimer = Timer.periodic(const Duration(seconds: 1), _timerUpdater);
  }

  void _onUpdateTime(
    UpdateTime event,
    Emitter<TimeModuleState> emit,
  ) {
    emit(state.copyWith(currentTime: event.newTime));
  }

  @override
  Future<void> close() {
    _updateTimer.cancel();
    return super.close();
  }
}
