import 'dart:async';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/core/constants/route_constants.dart';
import 'package:riverpod_standard/core/utils/utils.dart';
import 'package:riverpod_standard/features/home/presentation/providers/home_state_provider.dart';
import 'package:riverpod_standard/features/home/presentation/providers/state/home_state.dart';
import '../widgets/home_drawer.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  static const String routeName = RouteConstants.home;
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void scrollControllerListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      final notifier = ref.read(homeNotifierProvider.notifier);
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
    final state = ref.watch(homeNotifierProvider);

    ref.listen(homeNotifierProvider.select((value) => value), ((
      HomeState? previous,
      HomeState next,
    ) {
      if (next.state == HomeConcreteState.fetchedAllProducts) {
        if (next.message.isNotBlank) {
          context.showSnackBar(next.message);
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
                : const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              searchController.clear();
              setState(() {
                isSearchActive = !isSearchActive;
              });
              ref.read(homeNotifierProvider.notifier).resetState();
              if (!isSearchActive) {
                ref.read(homeNotifierProvider.notifier).fetchProducts();
              }
              refreshScrollControllerListener();
            },
            icon: Icon(isSearchActive ? Icons.clear : Icons.search),
          ),
        ],
      ),
      drawer: const HomeDrawer(),
      body:
          state.state == HomeConcreteState.loading
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
                  if (state.state == HomeConcreteState.fetchingMore)
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
      ref.read(homeNotifierProvider.notifier).searchProducts(query);
    });
  }
}
