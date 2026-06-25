import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/core/network/events/network_event.dart';
import 'package:riverpod_standard/features/session/presentation/providers/session_provider.dart';
import 'package:riverpod_standard/shared/providers/app_provider.dart';
import '../config/app_config_provider.dart';
import '../core/routes/app_route.dart';
import '../core/system/system_ui_config.dart';
import '../core/theme/app_theme.dart';
import '../core/widgets/internet_status_banner.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final appConfig = ref.watch(appConfigProvider);
    final themeMode = ref.watch(appThemeProvider);

    ref.listen(networkEventProvider, (_, next) {
      final event = next.valueOrNull;
      if (event == null) {
        return;
      }

      switch (event.type) {
        case NetworkEventType.unauthorized:
          unawaited(ref.read(sessionRepositoryProvider).deleteUser());
          unawaited(_appRouter.replaceAll([LoginRoute()]));
          _showSnackBar(context, event.message);
          break;
        case NetworkEventType.serverError:
          _showSnackBar(context, event.message);
          break;
      }
    });

    return MaterialApp.router(
      title: appConfig.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: _appRouter.delegate(),
      debugShowCheckedModeBanner: !appConfig.isProd,
      builder: (context, child) {
        return AnnotatedRegion(
          value: SystemUiConfig.overlayStyleFor(Theme.of(context).brightness),
          child: Stack(
            children: [if (child != null) child, const InternetStatusBanner()],
          ),
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(message)));
    });
  }
}
