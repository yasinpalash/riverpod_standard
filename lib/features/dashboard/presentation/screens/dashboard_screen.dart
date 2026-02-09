import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Providers
final totalSalesProvider = StateProvider<int>((ref) => 12500);
final totalOrdersProvider = StateProvider<int>((ref) => 320);
final totalCustomersProvider = StateProvider<int>((ref) => 98);

@RoutePage()
class DashboardScreen extends ConsumerStatefulWidget {
  static const String routeName = 'DashboardScreen';
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  bool isSearchActive = false;
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final totalSales = ref.watch(totalSalesProvider);
    final totalOrders = ref.watch(totalOrdersProvider);
    final totalCustomers = ref.watch(totalCustomersProvider);

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
                  onChanged: null,
                )
                : const Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(isSearchActive ? Icons.clear : Icons.search),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Greeting
            const Text(
              "Welcome Back 👋",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              "Your business overview",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            /// Summary Cards
            Row(
              children: [
                _summaryCard(
                  title: "Sales",
                  value: "৳${totalSales}",
                  icon: Icons.attach_money,
                  color: Colors.green,
                ),
                const SizedBox(width: 12),
                _summaryCard(
                  title: "Orders",
                  value: "$totalOrders",
                  icon: Icons.shopping_cart,
                  color: Colors.blue,
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                _summaryCard(
                  title: "Customers",
                  value: "$totalCustomers",
                  icon: Icons.people,
                  color: Colors.orange,
                ),
                const SizedBox(width: 12),
                _summaryCard(
                  title: "Reports",
                  value: "View",
                  icon: Icons.bar_chart,
                  color: Colors.purple,
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// Quick Actions
            const Text(
              "Quick Actions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _actionButton(Icons.add, "Add Sale", () {
                  ref.read(totalSalesProvider.notifier).state += 500;
                }),
                _actionButton(Icons.receipt, "Orders", () {}),
                _actionButton(Icons.people, "Customers", () {}),
                _actionButton(Icons.inventory, "Products", () {}),
                _actionButton(Icons.settings, "Settings", () {}),
                _actionButton(Icons.logout, "Logout", () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Summary Card
  Widget _summaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 26),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(title, style: TextStyle(color: Colors.grey.shade700)),
          ],
        ),
      ),
    );
  }

  /// Action Button
  Widget _actionButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Icon(icon, color: Theme.of(context).primaryColor),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
