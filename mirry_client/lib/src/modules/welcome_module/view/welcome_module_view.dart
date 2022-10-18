import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry_client/src/services/user_recognition/bloc/user_recognition_bloc.dart';

class WelcomeModuleView extends StatefulWidget {
  const WelcomeModuleView({Key? key}) : super(key: key);

  @override
  State<WelcomeModuleView> createState() => _WelcomeModuleViewState();
}

class _WelcomeModuleViewState extends State<WelcomeModuleView> {
  bool _showWelcomeTitle = false;

  @override
  void initState() {
    _onInit();
    super.initState();
  }

  Future<void> _onInit() async {
    await Future.delayed(const Duration(milliseconds: 600));
    _changeTitleShowing();
    await Future.delayed(const Duration(milliseconds: 2500));
    _changeTitleShowing();
  }

  void _changeTitleShowing() {
    setState(() {
      _showWelcomeTitle = !_showWelcomeTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserRecognitionBloc, UserRecognitionState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          switchInCurve: Curves.easeInCubic,
          switchOutCurve: Curves.easeOutCubic,
          child: _showWelcomeTitle && state.currentUser != null
              ? Text(
                  'Welcome, ${state.currentUser!.username}',
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                )
              : Container(),
        );
      },
    );
  }
}
