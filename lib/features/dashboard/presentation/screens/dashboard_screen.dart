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
  void initState() {
    super.initState();
    scrollController.addListener(scrollControllerListener);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void scrollControllerListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      final notifier = ref.read(dashboardNotifierProvider.notifier);
      if (isSearchActive) {
        notifier.searchProducts(searchController.text);
      } else {
        notifier.fetchProducts();
      }
    }
  }

  void refreshScrollControllerListener() {
    scrollController.removeListener(scrollControllerListener);
    scrollController.addListener(scrollControllerListener);
  }

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
            onPressed: () {
              searchController.clear();
              setState(() {
                isSearchActive = !isSearchActive;
              });
              ref.read(dashboardNotifierProvider.notifier).resetState();
              if (!isSearchActive) {
                ref.read(dashboardNotifierProvider.notifier).fetchProducts();
              }
              refreshScrollControllerListener();
            },
            icon: Icon(isSearchActive ? Icons.clear : Icons.search),
          ),
        ],
      ),
      drawer: const DashboardDrawer(),
      body:
          state.state == DashboardConcreteState.loading
              ? const Center(child: CircularProgressIndicator())
              : state.hasData
              ? Column(
                children: [
                  Expanded(
                    child: Scrollbar(
                      controller: scrollController,
                      child: ListView.separated(
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          final product = state.productList[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(product.thumbnail),
                            ),
                            title: Text(
                              product.title,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            trailing: Text(
                              '\$${product.price}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            subtitle: Text(
                              product.description,
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => const Divider(),
                        itemCount: state.productList.length,
                      ),
                    ),
                  ),
                  if (state.state == DashboardConcreteState.fetchingMore)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: CircularProgressIndicator(),
                    ),
                ],
              )
              : Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
