part of '../mirry_connection_repository.dart';

class MirryConnectionRepository
    with IHiveRepository<String>
    implements IMirryConnectionRepository {
  @override
  String get boxKey => 'mirryConnectionBoxKey';

  @override
  String get baseUrlKey => 'baseUrlKey';

  @override
  FutureOr<String?> getBaseUrlIp() async {
    return (await box).get(baseUrlKey);
  }

  @override
  Future<void> saveBaseUrlIp(String baseUrl) async {
    return (await box).put(baseUrlKey, baseUrl);
  }
}
