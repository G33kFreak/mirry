part of 'time_module_bloc.dart';

abstract class TimeModuleEvent extends Equatable {
  const TimeModuleEvent();

  @override
  List<Object?> get props => [];
}

@autoequalMixin
class InitTimeModule extends TimeModuleEvent
    with _$InitTimeModuleAutoequalMixin {
  const InitTimeModule();
}

@autoequalMixin
class UpdateTime extends TimeModuleEvent with _$UpdateTimeAutoequalMixin {
  final DateTime newTime;

  const UpdateTime({required this.newTime});
}
