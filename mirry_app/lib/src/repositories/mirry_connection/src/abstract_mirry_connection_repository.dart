part of '../mirry_connection_repository.dart';

abstract class IMirryConnectionRepository {
  String get baseUrlKey;

  FutureOr<String?> getBaseUrlIp();

  Future<void> saveBaseUrlIp(String baseUrl);
}
