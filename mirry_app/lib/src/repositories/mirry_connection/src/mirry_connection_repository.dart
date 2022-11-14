part of '../mirry_connection_repository.dart';

class MirryConnectionRepository
    with IHiveRepository<String>
    implements IMirryConnectionRepository {
  @override
  String get boxKey => 'mirryConnectionBoxKey';

  @override
  String get baseUrlKey => 'baseUrlKey';

  @override
  Future<String?> getBaseUrl() async {
    return (await box).get(baseUrlKey);
  }

  @override
  Future<void> saveBaseUrl(String baseUrl) async {
    return (await box).put(baseUrlKey, baseUrl);
  }
}
