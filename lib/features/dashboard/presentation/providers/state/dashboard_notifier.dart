import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/features/dashboard/presentation/providers/state/dashboard_state.dart';
import '../../../domain/repositories/dashboard_repository.dart';

class DashboardNotifier extends StateNotifier<DashboardState> {
  final DashboardRepository dashboardRepository;

  DashboardNotifier(this.dashboardRepository)
    : super(const DashboardState.initial());
}
