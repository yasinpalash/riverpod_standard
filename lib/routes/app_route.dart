import 'package:auto_route/auto_route.dart';
part 'app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter{
  @override
  RouteType get defaultRouteType =>
      const RouteType.material();
List<AutoRoute> get routes=>[

];
}