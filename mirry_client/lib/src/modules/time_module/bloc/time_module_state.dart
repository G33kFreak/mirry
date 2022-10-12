part of 'time_module_bloc.dart';

@autoequalMixin
class TimeModuleState extends Equatable with _$TimeModuleStateAutoequalMixin {
  final DateTime? currentTime;

  const TimeModuleState({
    this.currentTime,
  });

  TimeModuleState copyWith({
    DateTime? currentTime,
  }) =>
      TimeModuleState(
        currentTime: currentTime ?? this.currentTime,
      );
}
