import 'dart:async';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/features/dashboard/presentation/providers/dashboard_state_provider.dart';
import 'package:riverpod_standard/features/dashboard/presentation/providers/state/dashboard_state.dart';
import '../widgets/dashboard_drawer.dart';

@RoutePage()
class DashboardScreen extends ConsumerStatefulWidget {
  static const String routeName = 'DashboardScreen';
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final scrollController = ScrollController();
  bool isSearchActive = false;
  Timer? _debounce;
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardNotifierProvider);

    ref.listen(dashboardNotifierProvider.select((value) => value), ((
      DashboardState? previous,
      DashboardState next,
    ) {
      if (next.state == DashboardConcreteState.fetchedAllProducts) {
        if (next.message.isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(next.message.toString())));
        }
      }
    }));

    return Scaffold(
      appBar: AppBar(
        title:
            isSearchActive
                ? TextField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: 'Search here',
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  controller: searchController,
                  onChanged: _onSearchChanged,
                )
                : const Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(isSearchActive ? Icons.clear : Icons.search),
          ),
        ],
      ),
      drawer: const DashboardDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(dashboardNotifierProvider.notifier).searchProducts(query);
    });
  }
}
