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

const _timeToBrushInSeconds = 180;
const _timeFromPauseToFinishInSeconds = 30;

class TeethBrushingModuleBloc
    extends Bloc<TeethBrushingModuleEvent, TeethBrushingModuleState> {
  final MirrySocket _mirrySocket;
  PausableTimer? _timer;
  Timer? _pauseTimer;
  int _secondsInProcess = 0;

  TeethBrushingModuleBloc({required MirrySocket mirrySocket})
      : _mirrySocket = mirrySocket,
        super(const TeethBrushingModuleState()) {
    _setupSocketActions();
    on<ProgressChanged>(_onProgressChanged);
    on<BrushingStateChanged>(_onBrushingStateChanged);
  }

  void _setupSocketActions() {
    _mirrySocket.socketChannel.on(
      MirrySocketActions.brushingTeethStarted.value,
      (_) => add(const BrushingStateChanged(InProgressState())),
    );
    _mirrySocket.socketChannel.on(
      MirrySocketActions.brushingTeethStoped.value,
      (_) => _onStoped(),
    );
  }

  void _onStoped() {
    if (state.progress < 100) {
      _pauseTimer = Timer.periodic(
        const Duration(seconds: 1),
        _pauseTimerUpdater,
      );
      add(const BrushingStateChanged(PausedState()));
    } else {
      add(const BrushingStateChanged(FinishedState()));
    }
  }

  void _pauseTimerUpdater(Timer timer) {
    if (timer.tick > _timeFromPauseToFinishInSeconds) {
      add(const BrushingStateChanged(FinishedState()));
      _pauseTimer!.cancel();
    }
  }

  void _onBrushingStateChanged(
    BrushingStateChanged event,
    Emitter<TeethBrushingModuleState> emit,
  ) {
    if (event.newValue is InProgressState) {
      _pauseTimer?.cancel();
      if (_timer == null || !_timer!.isActive) {
        _timer = PausableTimer(const Duration(seconds: 1), _timerUpdater)
          ..start();
      } else {
        _timer!.start();
      }
    } else if (event.newValue is PausedState) {
      _timer!.pause();
    } else if (event.newValue is FinishedState) {
      _secondsInProcess = 0;
      _timer!.cancel();
      emit(state.copyWith(brushingState: const IdleState(), progress: 0));
      return;
    }

    emit(state.copyWith(brushingState: event.newValue));
  }

  void _timerUpdater() {
    final newProgressValue = _secondsInProcess * 100 / _timeToBrushInSeconds;
    _secondsInProcess++;
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
    _pauseTimer?.cancel();
    _mirrySocket.socketChannel.off(
      MirrySocketActions.brushingTeethStarted.value,
    );
    _mirrySocket.socketChannel.off(
      MirrySocketActions.brushingTeethStoped.value,
    );
    return super.close();
  }
}
