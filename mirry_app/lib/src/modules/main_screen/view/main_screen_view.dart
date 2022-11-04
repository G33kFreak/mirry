import 'package:flutter/material.dart';
import 'package:mirry/src/config/custom_icons/custom_icons_icons.dart';
import 'package:mirry/src/modules/main_screen/widgets/option_card.dart';
import 'package:mirry/src/widgets/m_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreenView extends StatelessWidget {
  const MainScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MAppbar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        children: [
          OptionCard(
            title: AppLocalizations.of(context)!.todo,
            description: AppLocalizations.of(context)!.todoDescription,
            onTap: () {},
            icon: Icons.list_rounded,
          ),
          const SizedBox(height: 16),
          OptionCard(
            title: AppLocalizations.of(context)!.currencies,
            description: AppLocalizations.of(context)!.currenciesDescription,
            onTap: () {},
            icon: Icons.currency_exchange_rounded,
          ),
          const SizedBox(height: 16),
          OptionCard(
            title: AppLocalizations.of(context)!.googleIntegration,
            description:
                AppLocalizations.of(context)!.googleIntegrationDescription,
            onTap: () {},
            icon: CustomIcons.google,
          ),
        ],
      ),
    );
  }
}
