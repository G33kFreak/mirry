part of '../settings_repository.dart';

class SettingsRepository
    with IHiveRepository<Settings>
    implements ISettingsRepository {
  final Dio _authHttpClient;
  final GetSettings _getSettings;

  SettingsRepository({
    required Dio authHttpClient,
    required GetSettings getSettings,
  })  : _authHttpClient = authHttpClient,
        _getSettings = getSettings;

  @override
  String get boxKey => 'settingsBoxKey';

  @override
  String get settingsKey => 'settingsKey';

  @override
  Future<Settings> getSettingsFromApi() async {
    final response = await _getSettings(_authHttpClient);

    try {
      return Settings.fromJson(response.data);
    } catch (e) {
      throw ApiResponseParseException(e.toString());
    }
  }

  @override
  Future<Settings?> getSettingsFromHive() async {
    return (await box).get(settingsKey);
  }

  @override
  Future<void> saveSettings(Settings settings) async {
    await (await box).put(settingsKey, settings);
  }
}
