import 'dart:developer';

import 'package:autoequal/autoequal.dart';
import 'package:dio/dio.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry/src/repositories/settings/models/settings.dart';
import 'package:mirry/src/repositories/settings/settings_repository.dart';
import 'package:mirry/src/utils/loading_state.dart';

part 'settings_event.dart';
part 'settings_state.dart';
part 'settings_bloc.g.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final ISettingsRepository _settingsRepository;

  SettingsBloc({
    required ISettingsRepository settingsRepository,
  })  : _settingsRepository = settingsRepository,
        super(const SettingsState()) {
    on<InitSettings>(_onInitSettings);
  }

  Future<void> _onInitSettings(
    InitSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(loadingState: const InProgressState()));
    try {
      final settingsFromApi = await _settingsRepository.getSettingsFromApi();
      await _settingsRepository.saveSettings(settingsFromApi);

      emit(state.copyWith(
        settings: settingsFromApi,
        loadingState: const SuccessState(),
      ));
    } on DioError catch (_) {
      await _attemptToLoadFromHive(emit);
    }
  }

  Future<void> _attemptToLoadFromHive(Emitter<SettingsState> emit) async {
    try {
      final settings = await _settingsRepository.getSettingsFromHive();

      emit(state.copyWith(
        settings: settings,
        loadingState: const SuccessState(),
      ));
    } catch (e) {
      log('error');
    }
  }
}
