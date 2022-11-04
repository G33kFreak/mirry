import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'settings.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Settings {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final TodoSettings? todo;
  @HiveField(2)
  final CurrenciesSettings? currencies;

  const Settings({
    required this.username,
    this.todo,
    this.currencies,
  });

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsToJson(this);
}

@HiveType(typeId: 2)
@JsonSerializable()
class TodoSettings {
  @HiveField(0)
  final int amountToShow;

  const TodoSettings({required this.amountToShow});

  factory TodoSettings.fromJson(Map<String, dynamic> json) =>
      _$TodoSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$TodoSettingsToJson(this);
}

@HiveType(typeId: 3)
@JsonSerializable()
class CurrenciesSettings {
  @HiveField(0)
  final List<String> pairsToShow;

  const CurrenciesSettings({required this.pairsToShow});

  factory CurrenciesSettings.fromJson(Map<String, dynamic> json) =>
      _$CurrenciesSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$CurrenciesSettingsToJson(this);
}
