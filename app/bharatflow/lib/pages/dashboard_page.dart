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
    final isTablet =
        MediaQuery.of(context).size.width >= 650 && MediaQuery.of(context).size.width < 1100;

    final stats = [
      {
        "title": "Travel time per 10 km",
        "value": "18 min 20 s",
        "textcolor": Colors.blueAccent,
        "subtext": "2 min 30 s above what's usual at this time",
        "subtextColor": Color(0xFF04063f),
        "bgColor": Colors.white,
      },
      {
        "title": "Congestion level",
        "value": "0%",
        "textcolor": Colors.blueAccent,
        "subtext": "0% usual for this time",
        "subtextColor": Color(0xFF04063f),
        "bgColor": Colors.white,
      },
      {
        "title": "Speed",
        "value": "32.7 km/h",
        "textcolor": Colors.blueAccent,
        "subtext": "5.2 km/h below what's usual at this time",
        "subtextColor": Color(0xFF04063f),
        "bgColor": Colors.white,
      },
      {
        "title": "Traffic jams",
        "value": "4\n1.7 km",
        "textcolor": Colors.blueAccent,
        "subtext": "Total count   Total length",
        "subtextColor": Color(0xFF04063f),
        "bgColor": Colors.white,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard Overview',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Monitor and manage traffic congestion across the city',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),

            // Stats Cards
            GridView.builder(
              padding: const EdgeInsets.all(0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isDesktop
                    ? 4
                    : isTablet
                    ? 2
                    : 1,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.6,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: stats.length,
              itemBuilder: (context, index) {
                final item = stats[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: item["bgColor"] as Color,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["title"] as String,
                        style: TextStyle(
                          color: item["bgColor"] == Colors.white ? Colors.black : Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item["value"] as String,
                        style: TextStyle(
                          color: item["textcolor"] != null
                              ? item["textcolor"] as Color
                              : (item["bgColor"] == Colors.white ? Colors.black : Colors.white),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        item["subtext"] as String,
                        style: TextStyle(
                          color: item["subtextColor"] as Color,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                );
              },
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

            // Traffic Incidents and Extra Chart
            Card(
              color: const Color(0xFF04063f),
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    const SizedBox(height: 24),
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
                        color: const Color(0xFF0040BD),
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
