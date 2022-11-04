import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry/src/config/routes/loading.dart';
import 'package:mirry/src/modules/welcome_screen/bloc/welcome_screen_bloc.dart';
import 'package:mirry/src/modules/welcome_screen/bloc/welcome_screen_bloc_provider.dart';
import 'package:mirry/src/modules/welcome_screen/utils/welcome_screen_utils.dart';
import 'package:mirry/src/modules/welcome_screen/widgets/signin_actions.dart';
import 'package:mirry/src/modules/welcome_screen/widgets/signup_actions.dart';
import 'package:mirry/src/utils/loading_state.dart';
import 'package:mirry/src/widgets/animated_app_icon.dart';
import 'package:mirry/src/widgets/m_input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeScreenView extends StatelessWidget with AutoRouteWrapper {
  const WelcomeScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<WelcomeScreenBloc, WelcomeScreenState>(
              builder: (context, state) {
                return Column(
                  children: [
                    const Spacer(),
                    Hero(
                      tag: LoadingScreenView.heroTag,
                      child: AnimatedAppIcon(
                        isAnimating: state.loadingState is InProgressState,
                      ),
                    ),
                    const Spacer(flex: 2),
                    MInput(
                      prefixIcon: Icons.person_rounded,
                      hintText: AppLocalizations.of(context)!.username,
                      onChange: (value) => context
                          .read<WelcomeScreenBloc>()
                          .add(ChangeUsername(value)),
                    ),
                    const SizedBox(height: 24),
                    MInput(
                      prefixIcon: Icons.lock_rounded,
                      hintText: AppLocalizations.of(context)!.password,
                      suffixIcon: state.hidePassword
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      obscureText: state.hidePassword,
                      onChange: (value) => context
                          .read<WelcomeScreenBloc>()
                          .add(ChangePassword(value)),
                      onSuffixTap: () => context
                          .read<WelcomeScreenBloc>()
                          .add(const TurnPasswordVisibility()),
                    ),
                    const SizedBox(height: 16),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) => SizeTransition(
                        sizeFactor: animation,
                        child: FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                      ),
                      layoutBuilder: (currentChild, previousChildren) => Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          ...previousChildren,
                          if (currentChild != null) currentChild,
                        ],
                      ),
                      child: state.screenMode == WelcomeScreenMode.signin
                          ? const SigninActions()
                          : const SignupActions(),
                    ),
                    const Spacer(flex: 8),
                    Text(
                      'Built by g33kFreak',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: const Color(0xFF484854)),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return WelcomeScreenBlocProvider(child: this);
  }
}
