import 'dart:async';

import 'package:autoequal/autoequal.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry_client/src/config/socket/mirry_socket.dart';
import 'package:mirry_client/src/config/socket/mirry_socket_actions.dart';
import 'package:mirry_client/src/services/user_recognition/models/user.dart';

part 'user_recognition_event.dart';
part 'user_recognition_state.dart';
part 'user_recognition_bloc.g.dart';

class UserRecognitionBloc
    extends Bloc<UserRecognitionEvent, UserRecognitionState> {
  final MirrySocket _mirrySocket;
  Timer? _changesTimer;

  UserRecognitionBloc({required MirrySocket mirrySocket})
      : _mirrySocket = mirrySocket,
        super(const UserRecognitionState()) {
    _setupSocketActions();
    on<UserChanged>(_onUserChanged);
  }

  void _setupSocketActions() {
    _mirrySocket.socketChannel.on(
      MirrySocketActions.faceRecognized.value,
      _onFaceRecognized,
    );
    _mirrySocket.socketChannel.on(
      MirrySocketActions.recognizedUserLeft.value,
      _onRecognizedLeft,
    );
  }

  void _onFaceRecognized(dynamic data) {
    final user = User.fromJson(data['user']);
    _changesTimer?.cancel();
    if (state.currentUser != user) {
      _changesTimer = Timer.periodic(
        const Duration(milliseconds: 100),
        (timer) => _timerUpdater(timer, () => add(UserChanged(user))),
      );
    }
  }

  void _onRecognizedLeft(dynamic _) {
    _changesTimer?.cancel();
    _changesTimer = Timer.periodic(
      const Duration(milliseconds: 200),
      (timer) => _timerUpdater(timer, () => add(const UserChanged(null))),
    );
  }

  void _timerUpdater(Timer timer, void Function() callback) {
    if (timer.tick >= 5) {
      callback.call();
    }
  }

  void _onUserChanged(
    UserChanged event,
    Emitter<UserRecognitionState> emit,
  ) {
    emit(state.copyWyth(currentUserId: event.newUser));
  }

  @override
  Future<void> close() {
    _mirrySocket.socketChannel.off(MirrySocketActions.faceRecognized.value);
    _changesTimer?.cancel();
    return super.close();
  }
}
