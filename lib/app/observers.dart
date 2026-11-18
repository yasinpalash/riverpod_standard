import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/core/logging/log_redactor.dart';
import 'package:riverpod_standard/core/logging/logging.dart';

final class Observers extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    final provider = context.provider;
    AppLogger.debug('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "${LogRedactor.redactAndTruncate(newValue, maxLength: 300)}"
}''');
  }

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    final provider = context.provider;
    AppLogger.debug('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "disposed"
}''');
  }
}
