import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry/src/modules/welcome_screen/bloc/welcome_screen_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mirry/src/widgets/m_button.dart';

class SigninActions extends StatelessWidget {
  const SigninActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WelcomeScreenBloc, WelcomeScreenState>(
      builder: (context, state) {
        return Column(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: AppLocalizations.of(context)!.firstTime,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  TextSpan(
                    text: ' ${AppLocalizations.of(context)!.signUp}!',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context
                            .read<WelcomeScreenBloc>()
                            .add(const ChangeScreenMode());
                      },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: MButton(
                onTap: () => context
                    .read<WelcomeScreenBloc>()
                    .add(const SignInPressed()),
                title: AppLocalizations.of(context)!.signIn,
                isBlocked: state.username.isEmpty || state.password.isEmpty,
              ),
            ),
          ],
        );
      },
    );
  }
}
