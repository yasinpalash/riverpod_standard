import 'package:riverpod_standard/core/services/haptic_service.dart';

class MicroInteractionService {
  const MicroInteractionService(this._hapticService);

  final HapticService _hapticService;

  Future<void> buttonTap() => _hapticService.selectionClick();

  Future<void> success() => _hapticService.lightImpact();

  Future<void> warning() => _hapticService.mediumImpact();

  Future<void> error() => _hapticService.heavyImpact();
}
