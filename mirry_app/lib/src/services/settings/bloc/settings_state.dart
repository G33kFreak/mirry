part of 'settings_bloc.dart';

@autoequalMixin
class SettingsState extends Equatable with _$SettingsStateAutoequalMixin {
  final Settings? settings;
  final LoadingState loadingState;

  const SettingsState({
    this.settings,
    this.loadingState = const IdleState(),
  });

  SettingsState copyWith({
    Settings? settings,
    LoadingState? loadingState,
  }) =>
      SettingsState(
        settings: settings ?? this.settings,
        loadingState: loadingState ?? this.loadingState,
      );
}
