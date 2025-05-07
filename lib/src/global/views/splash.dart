import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../feature/home/view/home.dart';
import '../../utils/config.dart';
import '../controller/init_controller.dart';
import '../providers/common_providers.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  static const routePath = "/splash";

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    if (AppConfig.devMode) {
      Future.delayed(const Duration(seconds: 2)).then((value) {
        context.go(HomeView.routePath);
      });
    } else {
      ref.read(initControllerProvider).initUserAndToken().then((value) {
        final user = ref.read(currentUserProvider);
        final token = ref.read(authTokenProvider);
        if (user == null || token == null) {
        } else {
          context.go(HomeView.routePath);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text(
          "Splash",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
