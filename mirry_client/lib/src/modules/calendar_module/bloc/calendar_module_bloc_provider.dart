import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry_client/src/config/api/http_client.dart';
import 'package:mirry_client/src/modules/calendar_module/bloc/calendar_module_bloc.dart';
import 'package:mirry_client/src/repositories/calendar_repository/calendar_repository.dart';
import 'package:mirry_client/src/services/user_recognition/bloc/user_recognition_bloc.dart';

class CalendarModuleBlocProvider extends StatelessWidget {
  final Widget child;

  const CalendarModuleBlocProvider({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ICalendarRepository>(
      create: (context) => CalendarRepository(
        httpClient: context.read<HttpClient>().httpClient,
        getEvents: getEvents,
      ),
      child: BlocProvider(
        create: (context) {
          final bloc = CalendarModuleBloc(
            calendarRepository: context.read<ICalendarRepository>(),
          );

          bloc.add(InitCalendar(
            userId: context.read<UserRecognitionBloc>().state.currentUser!.id,
          ));

          return bloc;
        },
        child: child,
      ),
    );
  }
}
