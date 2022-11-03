import 'package:json_annotation/json_annotation.dart';

part 'jwt_tokens.g.dart';

@JsonSerializable()
class JwtTokens {
  final String accessToken;
  final String refreshToken;

  const JwtTokens({required this.accessToken, required this.refreshToken});

  factory JwtTokens.fromJson(Map<String, dynamic> json) =>
      _$JwtTokensFromJson(json);

  Map<String, dynamic> toJson() => _$JwtTokensToJson(this);
}
