import 'package:autoequal/autoequal.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry_client/src/config/socket/mirry_socket.dart';
import 'package:mirry_client/src/config/socket/mirry_socket_actions.dart';

part 'user_recognition_event.dart';
part 'user_recognition_state.dart';
part 'user_recognition_bloc.g.dart';

class UserRecognitionBloc
    extends Bloc<UserRecognitionEvent, UserRecognitionState> {
  final MirrySocket _mirrySocket;

  UserRecognitionBloc({required MirrySocket mirrySocket})
      : _mirrySocket = mirrySocket,
        super(const UserRecognitionState()) {
    _setupSocketActions();
    on<UserChanged>(_onUserChanged);
  }

  void _setupSocketActions() {
    _mirrySocket.socketChannel.on(
      MirrySocketActions.faceRecognized.value,
      (data) => print(data),
    );
  }

  void _onUserChanged(
    UserChanged event,
    Emitter<UserRecognitionState> emit,
  ) {
    _mirrySocket.socketChannel.emit('test');
  }

  @override
  Future<void> close() {
    _mirrySocket.socketChannel.off(MirrySocketActions.faceRecognized.value);
    return super.close();
  }
}
