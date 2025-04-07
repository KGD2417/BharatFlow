import 'package:flutter/material.dart';
import '/components/chart_container.dart';
import '../components/stat_card.dart';
import '../components/traffic_map.dart';
import '/components/fl_chart.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  MapViewType _currentMapView = MapViewType.default_map;

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1100;
    final isTablet = MediaQuery.of(context).size.width >= 650 && MediaQuery.of(context).size.width < 1100;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard Overview',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Monitor and manage traffic congestion across the city',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 24),

            // Stats Cards
            GridView.count(
              crossAxisCount: isDesktop ? 4 : (isTablet ? 2 : 1),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                StatCard(
                  title: 'Average Congestion',
                  value: '42%',
                  icon: Icons.speed,
                  iconColor: Colors.orange,
                  backgroundColor: Color(0xFFFFF3E0),
                ),
                StatCard(
                  title: 'Signals Monitored',
                  value: '128',
                  icon: Icons.traffic,
                  iconColor: Colors.green,
                  backgroundColor: Color(0xFFE8F5E9),
                ),
                StatCard(
                  title: 'Critical Zones',
                  value: '3',
                  icon: Icons.warning,
                  iconColor: Colors.red,
                  backgroundColor: Color(0xFFFFEBEE),
                ),
                StatCard(
                  title: 'Last Update',
                  value: '2 min ago',
                  icon: Icons.update,
                  iconColor: Colors.blue,
                  backgroundColor: Color(0xFFE3F2FD),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Traffic Map
            TrafficMap(
              onViewTypeChanged: (viewType) {
                setState(() {
                  _currentMapView = viewType;
                });
              },
            ),

            const SizedBox(height: 24),

            // Charts
            SizedBox(
              height: 400,
              child: GridView.count(
                crossAxisCount: isDesktop ? 2 : 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: isDesktop ? 1.5 : 1,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ChartContainer(
                    title: 'Traffic Flow Over Time',
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                    chart: LineChartSample2(),
                  ),
                  ChartContainer(
                    title: 'Peak Hours Congestion',
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                    chart: LineChartSample2(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Traffic Incidents Section
            // Card(
            //   color: const Color(0xFF04063f), // Dark card color
            //   elevation: 8,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(16),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(24),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Row(
            //           children: [
            //             // const Text(
            //             //   'Traffic Incidents',
            //             //   style: TextStyle(
            //             //     fontWeight: FontWeight.bold,
            //             //     fontSize: 22,
            //             //     color: Colors.white,
            //             //   ),
            //             // ),
            //             //
            //
            //             const Spacer(),
            //             TextButton.icon(
            //               style: TextButton.styleFrom(
            //                 backgroundColor: Colors.blueAccent.withOpacity(0.2),
            //                 shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(8),
            //                 ),
            //               ),
            //               icon: const Icon(Icons.filter_list, color: Colors.blueAccent),
            //               label: const Text('Filter', style: TextStyle(color: Colors.blueAccent)),
            //               onPressed: () {},
            //             ),
            //           ],
            //         ),
            //
            //         const SizedBox(height: 24),
            Card(
              color: const Color(0xFF04063f), // Dark card color
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blueAccent.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.filter_list, color: Colors.blueAccent),
                      label: const Text('Filter', style: TextStyle(color: Colors.blueAccent)),
                      onPressed: () {},
                    ),

                    const SizedBox(height: 24), // Add some space after the button

                    SizedBox(
                      height: 400,
                      width: double.infinity,
                      child: ChartContainer(
                        title: 'Zone-wise Congestion',
                        actions: [
                          TextButton.icon(
                            icon: const Icon(Icons.download, color: Colors.white),
                            label: const Text('Export', style: TextStyle(color: Colors.white)),
                            onPressed: () {},
                          ),
                        ],
                        chart: LineChartSample2(),
                      ),
                    ),
                    const SizedBox(height: 24),

            // Recent Alerts - Only in heatmap view
                    if (_currentMapView == MapViewType.heatmap)
                      Card(
                        elevation: 2,
                        color: const Color(0xFF1A1C4A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Recent Alerts',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Spacer(),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text('View All'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              _buildAlertItem(
                                context,
                                'High congestion detected in Downtown',
                                '10 minutes ago',
                                Colors.red,
                              ),
                              const Divider(color: Colors.white24),
                              _buildAlertItem(
                                context,
                                'Signal malfunction at 5th Avenue',
                                '25 minutes ago',
                                Colors.orange,
                              ),
                              const Divider(color: Colors.white24),
                              _buildAlertItem(
                                context,
                                'Traffic flow normalized in West District',
                                '1 hour ago',
                                Colors.green,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertItem(BuildContext context, String message, String time, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white70),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
