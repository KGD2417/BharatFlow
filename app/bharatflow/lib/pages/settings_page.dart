import 'package:flutter/material.dart';
import 'package:bharatflow/components/traffic_map.dart';
import 'package:bharatflow/components/chart_container.dart';
import 'package:bharatflow/components/settings_card.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _aiPrediction = true;
  bool _realTimeControl = true;
  bool _automaticMode = true;
  bool _notifications = true;
  bool _dataSharing = false;
  
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
              'System Settings',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Configure traffic management system settings',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 24),
            
            // Traffic Control Settings
            Text(
              'Traffic Control',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SettingsCard(
              title: 'AI Prediction',
              description: 'Use AI to predict traffic patterns and optimize signal timing',
              value: _aiPrediction,
              onChanged: (value) {
                setState(() {
                  _aiPrediction = value;
                });
              },
              icon: Icons.psychology,
            ),
            const SizedBox(height: 12),
            SettingsCard(
              title: 'Real-time Signal Control',
              description: 'Allow system to adjust traffic signals in real-time',
              value: _realTimeControl,
              onChanged: (value) {
                setState(() {
                  _realTimeControl = value;
                });
              },
              icon: Icons.timer,
            ),
            const SizedBox(height: 12),
            SettingsCard(
              title: 'Automatic Mode',
              description: 'Switch between automatic and manual control modes',
              value: _automaticMode,
              onChanged: (value) {
                setState(() {
                  _automaticMode = value;
                });
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      value 
                        ? 'Switched to Automatic Mode' 
                        : 'Switched to Manual Mode'
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: Icons.auto_mode,
            ),
            
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),
            
            // Notification Settings
            Text(
              'Notifications',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SettingsCard(
              title: 'Push Notifications',
              description: 'Receive alerts for critical traffic events',
              value: _notifications,
              onChanged: (value) {
                setState(() {
                  _notifications = value;
                });
              },
              icon: Icons.notifications,
            ),
            const SizedBox(height: 12),
            SettingsCard(
              title: 'Data Sharing',
              description: 'Share anonymous traffic data with city planning',
              value: _dataSharing,
              onChanged: (value) {
                setState(() {
                  _dataSharing = value;
                });
              },
              icon: Icons.share,
            ),
            
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),
            
            // Data Management
            Text(
              'Data Management',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.storage,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Export Traffic Data',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Download traffic data in CSV or JSON format',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.file_download),
                            label: const Text('CSV'),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Exporting data as CSV...'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.file_download),
                            label: const Text('JSON'),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Exporting data as JSON...'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.errorContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.delete_outline,
                            color: theme.colorScheme.error,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Clear Historical Data',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Remove all historical traffic data older than selected period',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: '30 Days',
                      decoration: const InputDecoration(
                        labelText: 'Data Older Than',
                        isDense: true,
                      ),
                      items: [
                        '7 Days',
                        '30 Days',
                        '90 Days',
                        '1 Year',
                        'All Data',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {},
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.delete_forever),
                        label: const Text('Clear Data'),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Confirm Data Deletion'),
                              content: const Text(
                                'Are you sure you want to delete historical traffic data? This action cannot be undone.'
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                FilledButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Historical data has been cleared'),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.error,
                          foregroundColor: theme.colorScheme.onError,
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
}

