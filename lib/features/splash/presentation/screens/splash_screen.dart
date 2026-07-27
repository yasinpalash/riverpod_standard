import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/core/localization/locale_keys.g.dart';
import 'package:riverpod_standard/core/constants/route_constants.dart';
import 'package:riverpod_standard/features/splash/presentation/providers/splash_provider.dart';
import '../../../../core/routes/app_route.dart';

@RoutePage()
class SplashScreen extends ConsumerStatefulWidget {
  static const String routeName = RouteConstants.splash;
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      final isUserLoggedIn = await ref.read(userLoginCheckProvider.future);
      final route =
          isUserLoggedIn ? const HomeRoute() : LoginRoute() as PageRouteInfo;

      // ignore: use_build_context_synchronously
      AutoRouter.of(context).pushAndPopUntil(route, predicate: (_) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Text(
              LocaleKeys.app_splash,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
              ),
            ).tr(),
      ),
    );
  }
}
