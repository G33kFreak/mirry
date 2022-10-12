import 'package:mirry_client/src/environment/variables.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class MirrySocket {
  late final io.Socket socketChannel;

  MirrySocket() {
    _connectToSocket();
  }

  String get wsUrl => EnvironmentVariables.baseUrl.replaceFirst('http', 'ws');

  void _connectToSocket() {
    socketChannel = io.io(
      wsUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setPath('/${EnvironmentVariables.mirrorApiKey}')
          .build(),
    );
  }
}
