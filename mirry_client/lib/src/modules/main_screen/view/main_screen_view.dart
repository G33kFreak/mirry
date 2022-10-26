import 'package:flutter/material.dart';
import 'package:mirry_client/src/modules/calendar_module/view/calendar_module_view.dart';
import 'package:mirry_client/src/modules/teeth_brusing_module/view/brushing_teeth_view.dart';
import 'package:mirry_client/src/modules/time_module/view/time_module_view.dart';
import 'package:mirry_client/src/modules/todo_module/view/todo_module_view.dart';
import 'package:mirry_client/src/modules/weather_module/view/weather_module_view.dart';
import 'package:mirry_client/src/modules/welcome_module/view/welcome_module_view.dart';

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const TimeModuleView(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: WeatherModuleView(),
                ),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: const [
                      BrushingTeethView(),
                      WelcomeModuleView(),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      TodoModuleView(),
                      SizedBox(height: 16),
                      CalendarModuleView(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
