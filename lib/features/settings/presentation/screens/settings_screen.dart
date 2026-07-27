import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/core/localization/locale_keys.g.dart';
import 'package:riverpod_standard/core/localization/locale_provider.dart';

@RoutePage()
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLocale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.settings_title).tr()),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child:
                Text(
                  LocaleKeys.settings_language,
                  style: Theme.of(context).textTheme.titleMedium,
                ).tr(),
          ),
          RadioGroup<Locale>(
            groupValue: selectedLocale,
            onChanged: (locale) => _setLocale(ref, locale),
            child: Column(
              children: [
                RadioListTile<Locale>(
                  title: Text(LocaleKeys.settings_english).tr(),
                  value: const Locale('en'),
                ),
                RadioListTile<Locale>(
                  title: Text(LocaleKeys.settings_bangla).tr(),
                  value: const Locale('bn'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _setLocale(WidgetRef ref, Locale? locale) {
    if (locale == null) {
      return;
    }

    ref.read(localeProvider.notifier).setLocale(locale);
  }
}
