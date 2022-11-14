part of '../mirry_connection_repository.dart';

abstract class IMirryConnectionRepository {
  String get baseUrlKey;

  Future<String?> getBaseUrl();

  Future<void> saveBaseUrl(String baseUrl);
}
