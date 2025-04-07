import 'package:flutter/material.dart';

class AppSidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const AppSidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width >= 1100;

    return NavigationDrawer(
      selectedIndex: selectedIndex,
      onDestinationSelected: onItemSelected,
      elevation: isDesktop ? 0 : 1,
      backgroundColor: const Color(0xffffffff),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 28, 16, 16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF3243f5),
                  // borderRadius: BorderRadius.circular(0),
                ),
                child: const Icon(
                  Icons.traffic,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Admin',
                      style: TextStyle(
                        color: Color(0xFF04063f),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: 'Panel',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Divider(color: Colors.black),
        const SizedBox(height: 8),
        NavigationDrawerDestination(
          icon: const Icon(Icons.dashboard_outlined, color: Colors.black),
          selectedIcon: const Icon(Icons.dashboard, color: Colors.black),
          label: const Text('Dashboard', style: TextStyle(color: Colors.black)),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.map_outlined, color: Colors.black),
          selectedIcon: const Icon(Icons.map, color: Colors.black),
          label: const Text('Heatmap Control', style: TextStyle(color: Colors.black)),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.analytics_outlined, color: Colors.black),
          selectedIcon: const Icon(Icons.analytics, color: Colors.black),
          label: const Text('Analytics', style: TextStyle(color: Colors.black)),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.settings_outlined, color: Colors.black),
          selectedIcon: const Icon(Icons.settings, color: Colors.black),
          label: const Text('Settings', style: TextStyle(color: Colors.black)),
        ),
        const SizedBox(height: 8),
        const Divider(color: Colors.black),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          // child: Text(
          //   'System Status',
          //   style: theme.textTheme.titleSmall?.copyWith(
          //     color: Colors.black,
          //   ),
          // ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  // color: Colors.green,
                  // borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              // const Text(
              //   'All Systems Operational',
              //   style: TextStyle(color: Colors.black),
              // ),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(
                Icons.account_circle,
                size: 32,
                color: Colors.black,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Admin User',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'admin@bharatflow.com',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.logout, size: 20, color: Colors.black),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

