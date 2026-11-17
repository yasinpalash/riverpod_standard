import 'package:auto_route/auto_route.dart';
import 'package:riverpod_standard/features/authentication/presentation/screens/login_screen.dart';
import 'package:riverpod_standard/features/home/presentation/screens/home_screen.dart';
import 'package:riverpod_standard/features/splash/presentation/screens/splash_screen.dart';

part 'app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: HomeRoute.page),
  ];
}
