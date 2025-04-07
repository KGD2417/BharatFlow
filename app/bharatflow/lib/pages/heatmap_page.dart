import 'package:flutter/material.dart';
// import '../components/traffic_map.dart';
import 'package:bharatflow/components/traffic_map.dart';

class HeatmapPage extends StatefulWidget {
  const HeatmapPage({super.key});

  @override
  State<HeatmapPage> createState() => _HeatmapPageState();
}

class _HeatmapPageState extends State<HeatmapPage> {
  String _selectedZone = 'None';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manual Heatmap Control',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Manually adjust traffic congestion levels and apply overrides',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 24),

            // Control Panel
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Control Panel',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selected Zone:',
                                style: theme.textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _selectedZone,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reset All'),
                          onPressed: () {
                            setState(() {
                              _selectedZone = 'None';
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('All zones have been reset'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
                    Text(
                      'Congestion Level',
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildCongestionButton(
                          context,
                          'Low',
                          Colors.green,
                          _selectedZone != 'None',
                        ),
                        const SizedBox(width: 8),
                        _buildCongestionButton(
                          context,
                          'Medium',
                          Colors.orange,
                          _selectedZone != 'None',
                        ),
                        const SizedBox(width: 8),
                        _buildCongestionButton(
                          context,
                          'High',
                          Colors.red,
                          _selectedZone != 'None',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Interactive Traffic Map
            TrafficMap(
              isInteractive: true,
              onZoneTap: (row, col) {
                setState(() {
                  _selectedZone = 'Zone $row-$col';
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Selected $_selectedZone for manual control'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCongestionButton(
      BuildContext context, String label, Color color, bool enabled) {
    return Expanded(
      child: ElevatedButton(
        onPressed: enabled
            ? () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
              Text('Set $_selectedZone to $label congestion'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          disabledBackgroundColor: color.withOpacity(0.3),
          disabledForegroundColor: Colors.white.withOpacity(0.5),
        ),
        child: Text(label),
      ),
    );
  }
}
