part of 'mirry_connection_service_bloc.dart';

abstract class MirryConnectionServiceState extends Equatable {
  const MirryConnectionServiceState();

  @override
  List<Object> get props => [];
}

class MirryConnectionUnknownState extends MirryConnectionServiceState {}

class MirryConnectedState extends MirryConnectionServiceState {
  final String baseUrl;

  const MirryConnectedState({required this.baseUrl});
}

class MirryNotConnectedState extends MirryConnectionServiceState {}
