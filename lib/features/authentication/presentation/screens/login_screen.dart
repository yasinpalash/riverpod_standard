import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/core/constants/app_strings.dart';
import 'package:riverpod_standard/core/constants/route_constants.dart';
import 'package:riverpod_standard/core/utils/utils.dart';
import 'package:riverpod_standard/core/widgets/app_button.dart';
import 'package:riverpod_standard/features/authentication/presentation/providers/auth_providers.dart';
import 'package:riverpod_standard/features/authentication/presentation/providers/state/auth_state.dart';
import '../../../../core/routes/app_route.dart';
import '../widgets/auth_field.dart';

@RoutePage()
class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = RouteConstants.login;
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController(
    text: 'emilys',
  );
  final TextEditingController passwordController = TextEditingController(
    text: 'emilyspass',
  );

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authStateNotifierProvider);
    ref.listen(authStateNotifierProvider.select((value) => value), ((
      previous,
      next,
    ) {
      if (next is Failure) {
        context.showErrorSnackBar(next.exception.message.toString());
      } else if (next is Success) {
        AutoRouter.of(
          context,
        ).pushAndPopUntil(const HomeRoute(), predicate: (_) => false);
      }
    }));

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appTitle)),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade50, Colors.purple.shade50],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withValues(alpha: 0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.lock_outline_rounded,
                        size: 50,
                        color: Colors.blue.shade600,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      AppStrings.welcomeBack,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3142),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      AppStrings.loginSubtitle,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 48),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                AuthField(
                                  hintText: AppStrings.username,
                                  controller: usernameController,
                                  validator: AppValidator.validateUsername,
                                  textInputAction: TextInputAction.next,
                                ),
                                const SizedBox(height: 16),
                                AuthField(
                                  hintText: AppStrings.password,
                                  obscureText: true,
                                  controller: passwordController,
                                  validator: AppValidator.validatePassword,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) => login(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          loginButton(
                            isLoading: state.maybeMap(
                              loading: (_) => true,
                              orElse: () => false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton({required bool isLoading}) {
    return AppButton(
      label: AppStrings.login,
      onPressed: login,
      isLoading: isLoading,
    );
  }

  void login() {
    context.dismissKeyboard();
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    ref
        .read(authStateNotifierProvider.notifier)
        .loginUser(
          AppHelper.normalizeWhitespace(usernameController.text),
          passwordController.text.trim(),
        );
  }
}
