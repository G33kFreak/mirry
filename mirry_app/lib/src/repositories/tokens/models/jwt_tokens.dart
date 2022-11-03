import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'jwt_tokens.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class JwtTokens {
  @HiveField(0)
  final String accessToken;

  @HiveField(1)
  final String refreshToken;

  const JwtTokens({required this.accessToken, required this.refreshToken});

  factory JwtTokens.fromJson(Map<String, dynamic> json) =>
      _$JwtTokensFromJson(json);

  Map<String, dynamic> toJson() => _$JwtTokensToJson(this);
}
