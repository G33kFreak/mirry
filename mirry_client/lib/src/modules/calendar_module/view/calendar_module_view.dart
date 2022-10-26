import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry_client/src/modules/calendar_module/bloc/calendar_module_bloc.dart';
import 'package:mirry_client/src/modules/calendar_module/bloc/calendar_module_bloc_provider.dart';
import 'package:mirry_client/src/repositories/calendar_repository/calendar_repository.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarModuleView extends StatelessWidget {
  const CalendarModuleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CalendarModuleBlocProvider(
      child: BlocBuilder<CalendarModuleBloc, CalendarModuleState>(
        builder: (context, state) {
          return SizedBox(
            width: 250,
            height: 500,
            child: SfCalendar(
              initialDisplayDate: DateTime.now()
                  .toLocal()
                  .subtract(const Duration(minutes: 20)),
              dataSource: EventDataSource(state.events),
              appointmentTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
              view: CalendarView.day,
              todayHighlightColor: Colors.white,
              todayTextStyle: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.black),
              timeSlotViewSettings: const TimeSlotViewSettings(
                timeIntervalHeight: 80,
              ),
            ),
          );
        },
      ),
    );
  }
}
