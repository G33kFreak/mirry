import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry/src/config/theme/colors.dart';
import 'package:mirry/src/modules/loading_screen/view/loading_screen_view.dart';
import 'package:mirry/src/services/settings/bloc/settings_bloc.dart';
import 'package:mirry/src/widgets/animated_app_icon.dart';

class MAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return SafeArea(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: accentDark,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Hero(
                  tag: LoadingScreenView.heroTag,
                  child: AnimatedAppIcon(
                    isAnimating: true,
                    size: 48,
                  ),
                ),
                const SizedBox(width: 16),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    state.settings?.username ?? '',
                    key: ValueKey(state.settings?.username ?? ''),
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
