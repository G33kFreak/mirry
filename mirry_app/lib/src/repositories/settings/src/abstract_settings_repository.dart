part of '../settings_repository.dart';

abstract class ISettingsRepository {
  String get settingsKey;

  Future<Settings?> getSettingsFromHive();

  Future<void> saveSettings(Settings settings);

  Future<Settings> getSettingsFromApi();
}
