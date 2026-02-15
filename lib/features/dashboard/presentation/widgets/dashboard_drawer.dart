import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/theme/app_theme.dart';

class DashboardDrawer extends ConsumerWidget {
  const DashboardDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      bottom: false,
      child: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
              ),
              accountName: Text(
                "Yasin",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              accountEmail: Text(
                "yasinmai@gmail.com",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              // currentAccountPicture: CircleAvatar(
              //   backgroundImage: NetworkImage('${currentUser?.image}'),
              // ),
              otherAccountsPictures: [
                InkWell(
                  onTap: () async {},
                  child: CircleAvatar(
                    child: Icon(
                      Icons.logout,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    ref.read(appThemeProvider.notifier).toggleTheme();
                  },
                  child: CircleAvatar(
                    child: Icon(
                      Theme.of(context).brightness == Brightness.dark
                          ? Icons.light_mode
                          : Icons.dark_mode,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
