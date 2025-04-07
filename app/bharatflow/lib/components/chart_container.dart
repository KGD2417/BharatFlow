import 'package:flutter/material.dart';
import 'package:bharatflow/components/traffic_map.dart';
import 'package:bharatflow/components/chart_container.dart';
import 'package:bharatflow/components/settings_card.dart';

class ChartContainer extends StatelessWidget {
  final String title;
  final Widget chart;
  final List<Widget>? actions;

  const ChartContainer({
    super.key,
    required this.title,
    required this.chart,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (actions != null) ...actions!,
              ],
            ),
            const SizedBox(height: 16),
            Expanded(child: chart),
          ],
        ),
      ),
    );
  }
}

