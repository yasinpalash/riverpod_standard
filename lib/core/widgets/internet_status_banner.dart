import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/core/constants/app_strings.dart';
import 'package:riverpod_standard/shared/providers/app_provider.dart';

class InternetStatusBanner extends ConsumerWidget {
  const InternetStatusBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasConnection = ref.watch(connectivityStatusProvider).valueOrNull;
    final showBanner = hasConnection == false;
    final colorScheme = Theme.of(context).colorScheme;

    return IgnorePointer(
      ignoring: !showBanner,
      child: SafeArea(
        minimum: const EdgeInsets.fromLTRB(12, 0, 12, 16),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedSlide(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            offset: showBanner ? Offset.zero : const Offset(0, 1.4),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 180),
              opacity: showBanner ? 1 : 0,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colorScheme.inverseSurface,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.18),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.wifi_off_rounded,
                          color: colorScheme.onInverseSurface,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            AppStrings.noInternetConnection,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onInverseSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
