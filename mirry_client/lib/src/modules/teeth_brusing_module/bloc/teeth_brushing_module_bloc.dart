import 'dart:async';

import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry_client/src/config/socket/mirry_socket.dart';
import 'package:mirry_client/src/config/socket/mirry_socket_actions.dart';
import 'package:mirry_client/src/modules/teeth_brusing_module/utils/brushing_state.dart';
import 'package:pausable_timer/pausable_timer.dart';

part 'teeth_brushing_module_event.dart';
part 'teeth_brushing_module_state.dart';
part 'teeth_brushing_module_bloc.g.dart';

const _timeToBrushInSeconds = 40; //180;

class TeethBrushingModuleBloc
    extends Bloc<TeethBrushingModuleEvent, TeethBrushingModuleState> {
  final MirrySocket _mirrySocket;
  PausableTimer? _timer;

  TeethBrushingModuleBloc({required MirrySocket mirrySocket})
      : _mirrySocket = mirrySocket,
        super(const TeethBrushingModuleState()) {
    _setupSocketActions();
    on<ProgressChanged>(_onProgressChanged);
    on<BrushingStateChanged>(_onBrushingStateChanged);
  }

  //TODO: Add logic with paused and finished
  void _setupSocketActions() {
    _mirrySocket.socketChannel.on(
      MirrySocketActions.brushingTeethStarted.value,
      (_) => add(const BrushingStateChanged(InProgressState())),
    );
  }

  void _onBrushingStateChanged(
    BrushingStateChanged event,
    Emitter<TeethBrushingModuleState> emit,
  ) {
    if (event.newValue is InProgressState) {
      if (_timer == null || !_timer!.isActive) {
        _timer = PausableTimer(const Duration(seconds: 1), _timerUpdater)
          ..start();
      } else {
        _timer!.start();
      }
    } else if (event.newValue is PausedState) {
      _timer!.pause();
    } else if (event.newValue is FinishedState) {
      _timer!.cancel();
      emit(state.copyWith(brushingState: const IdleState(), progress: 100));
      return;
    }

    emit(state.copyWith(brushingState: event.newValue));
  }

  void _timerUpdater() {
    final newProgressValue = _timer!.tick * 100 / _timeToBrushInSeconds;
    if (newProgressValue >= 100) {
      add(const BrushingStateChanged(FinishedState()));
    } else {
      if (newProgressValue.toInt() > state.progress) {
        add(ProgressChanged(newProgressValue.toInt()));
      }

      _timer!
        ..reset()
        ..start();
    }
  }

  void _onProgressChanged(
    ProgressChanged event,
    Emitter<TeethBrushingModuleState> emit,
  ) {
    emit(state.copyWith(progress: event.newValue));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
