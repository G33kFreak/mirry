import 'package:flutter/widgets.dart';
import 'package:mirry/src/services/hive.dart';

import 'src/app.dart';

Future<void> main() => boot();

Future<void> boot() async {
  await setupHive();
  runApp(MyApp());
}
