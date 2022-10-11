import 'package:flutter/material.dart';
import 'package:mirry_client/src/modules/time_module/view/time_module_view.dart';

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: const [
              TimeModuleView(),
            ],
          ),
        ),
      ),
    );
  }
}
