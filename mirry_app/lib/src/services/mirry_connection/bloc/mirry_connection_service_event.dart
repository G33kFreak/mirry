part of 'mirry_connection_service_bloc.dart';

abstract class MirryConnectionServiceEvent extends Equatable {
  const MirryConnectionServiceEvent();

  @override
  List<Object?> get props => [];
}

@autoequalMixin
class MirryConnectionStateChanged extends MirryConnectionServiceEvent
    with _$MirryConnectionStateChangedAutoequalMixin {
  final bool isConnected;
  final String? baseUrl;

  const MirryConnectionStateChanged({
    required this.isConnected,
    this.baseUrl,
  }) : assert(
          isConnected ? baseUrl != null : baseUrl == null,
        );
}

@autoequalMixin
class InitMirryConnectionService extends MirryConnectionServiceEvent
    with _$InitMirryConnectionServiceAutoequalMixin {
  const InitMirryConnectionService();
}
