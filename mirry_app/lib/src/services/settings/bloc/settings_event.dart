part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

@autoequalMixin
class InitSettings extends SettingsEvent with _$InitSettingsAutoequalMixin {
  const InitSettings();
}
