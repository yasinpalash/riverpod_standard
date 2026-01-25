import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:riverpod_standard/features/splash/presentation/providers/splash_provider.dart';

@RoutePage()
class SplashScreen extends ConsumerStatefulWidget {
  static const String routeName = '/splashScreen';
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
Future.delayed(const Duration(seconds: 2),()async{
  final isUserLoggedIn=await ref.read(userLoginCheckProvider.future);
 // final route=isUserLoggedIn? const DashboardScreen(): const
});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'Splash Screen',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
