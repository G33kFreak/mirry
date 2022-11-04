import 'package:flutter/material.dart';
import 'package:mirry/src/widgets/m_appbar.dart';

class MainScreenView extends StatelessWidget {
  const MainScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MAppbar(),
      body: Center(child: Text('main screen')),
    );
  }
}
