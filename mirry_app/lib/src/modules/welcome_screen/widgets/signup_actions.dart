import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry/src/config/routes.dart';
import 'package:mirry/src/modules/welcome_screen/bloc/welcome_screen_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mirry/src/widgets/m_button.dart';

class SignupActions extends StatelessWidget {
  const SignupActions({Key? key}) : super(key: key);

  Future<void> _toUploadFace(BuildContext context) async {
    final file = await context.router.pushNamed(
      Routes.uploadFace.generatePath(),
    );

    if (file != null) {
      Future.delayed(
        Duration.zero,
        () => _savePhotoToState(file as File, context),
      );
    }
  }

  void _savePhotoToState(File file, BuildContext context) {
    context.read<WelcomeScreenBloc>().add(UploadPhoto(file: file));
  }

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
                    text: AppLocalizations.of(context)!.alreadyUse,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  TextSpan(
                    text: ' ${AppLocalizations.of(context)!.signIn}!',
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
                onTap: () => _toUploadFace(context),
                title: state.photo == null
                    ? AppLocalizations.of(context)!.uploadPhoto
                    : AppLocalizations.of(context)!.changePhoto,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: MButton(
                onTap: () => context
                    .read<WelcomeScreenBloc>()
                    .add(const SignUpPressed()),
                title: AppLocalizations.of(context)!.signIn,
                isBlocked: state.username.isEmpty ||
                    state.password.isEmpty ||
                    state.photo == null,
              ),
            ),
          ],
        );
      },
    );
  }
}
