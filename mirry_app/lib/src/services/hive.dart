import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mirry/src/repositories/settings/models/settings.dart';
import 'package:mirry/src/repositories/tokens/models/jwt_tokens.dart';

Future<void> setupHive() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  _registerAdapters();
}

void _registerAdapters() {
  Hive.registerAdapter<JwtTokens>(JwtTokensAdapter());
  Hive.registerAdapter<Settings>(SettingsAdapter());
  Hive.registerAdapter<TodoSettings>(TodoSettingsAdapter());
  Hive.registerAdapter<CurrenciesSettings>(CurrenciesSettingsAdapter());
}

abstract class IHiveRepository<E> {
  Box<E>? _box;

  String get boxKey;

  Future<Box<E>> get box async {
    _box ??= await Hive.openBox<E>(boxKey);
    return _box!;
  }
}
