import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry/src/repositories/mirry_connection/mirry_connection_repository.dart';

part 'mirry_connection_service_event.dart';
part 'mirry_connection_service_state.dart';
part 'mirry_connection_service_bloc.g.dart';

class MirryConnectionServiceBloc
    extends Bloc<MirryConnectionServiceEvent, MirryConnectionServiceState> {
  final IMirryConnectionRepository _mirryConnectionRepository;
  Timer? _connectionChangesTimer;

  MirryConnectionServiceBloc({
    required IMirryConnectionRepository mirryConnectionRepository,
  })  : _mirryConnectionRepository = mirryConnectionRepository,
        super(MirryConnectionUnknownState()) {
    on<MirryConnectionStateChanged>(_onMirryConnectionStateChanged);
    on<InitMirryConnectionService>(_onInitMirryConnectionService);
  }

  static const _ipArea = '192.168.1.';

  void _socketListener(
    Socket socket,
    String address,
    int port, {
    bool shouldSave = false,
  }) {
    if (shouldSave) {
      _mirryConnectionRepository.saveBaseUrl(address);
      log('[Connection service] Saved base url: $address');
    }
    add(MirryConnectionStateChanged(isConnected: true, baseUrl: address));
    log('[Connection service] Connected to Mirry');
    socket.listen(
      (event) {},
      onDone: () async {
        _connectionChangesTimer = Timer.periodic(
          const Duration(milliseconds: 100),
          _connectionTimer,
        );
        await _reconnect(socket, address: address, port: port);
      },
      onError: (_) {},
    );
  }

  Future<void> _onInitMirryConnectionService(
    InitMirryConnectionService event,
    Emitter<MirryConnectionServiceState> emit,
  ) async {
    final baseUrl = await _mirryConnectionRepository.getBaseUrl();

    if (baseUrl != null) {
      Socket.connect(baseUrl, 8000).then(
        (socket) => _socketListener(socket, baseUrl, 8000),
        onError: (_) async {
          await _reconnect(null, address: baseUrl, port: 8000);
        },
      );
    } else {
      for (int i = 1; i <= 255; i++) {
        final ip = '$_ipArea$i';
        log('[Connection service] Looking for Mirry: $ip');
        try {
          final socket = await Socket.connect(
            '$_ipArea$i',
            8000,
            timeout: const Duration(milliseconds: 200),
          );
          _socketListener(socket, ip, 8000, shouldSave: true);
          break;
        } catch (_) {
          log('[Connection service] $ip failed');
        }
      }
    }
  }

  Future<void> _reconnect(
    Socket? socket, {
    required String address,
    required int port,
  }) async {
    socket?.destroy();
    await Future.delayed(const Duration(milliseconds: 5));
    try {
      final newSocket = await Socket.connect(address, port);
      _socketListener(newSocket, address, port);
    } catch (e) {
      await _reconnect(socket, address: address, port: port);
    }
  }

  void _connectionTimer(Timer timer) {
    if (timer.tick > 5) {
      add(const MirryConnectionStateChanged(isConnected: false));
      log('[Connection service] Connection to Mirry is lost');
      timer.cancel();
    }
  }

  void _onMirryConnectionStateChanged(
    MirryConnectionStateChanged event,
    Emitter<MirryConnectionServiceState> emit,
  ) {
    _connectionChangesTimer?.cancel();
    emit(event.isConnected
        ? MirryConnectedState(baseUrl: event.baseUrl!)
        : MirryNotConnectedState());
  }

  @override
  Future<void> close() {
    _connectionChangesTimer?.cancel();
    return super.close();
  }
}
