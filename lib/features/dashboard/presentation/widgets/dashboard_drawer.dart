import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardDrawer extends ConsumerWidget {
  const DashboardDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return SafeArea(
      bottom: false,
      child: Drawer(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
