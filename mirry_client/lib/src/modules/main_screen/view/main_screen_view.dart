import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry_client/src/modules/time_module/view/time_module_view.dart';
import 'package:mirry_client/src/services/user_recognition/bloc/user_recognition_bloc.dart';

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TimeModuleView(),
              OutlinedButton(
                onPressed: () => context
                    .read<UserRecognitionBloc>()
                    .add(UserChanged('test')),
                child: Text('test'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
