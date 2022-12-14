import 'package:equatable/equatable.dart';

abstract class LoadingState extends Equatable {
  const LoadingState();
}

class IdleState extends LoadingState {
  const IdleState();

  @override
  List<Object?> get props => [];
}

class InProgressState extends LoadingState {
  const InProgressState();

  @override
  List<Object?> get props => [];
}

class SuccessState extends LoadingState {
  const SuccessState();

  @override
  List<Object?> get props => [];
}

class FailedState extends LoadingState {
  const FailedState();

  @override
  List<Object?> get props => [];
}
