// safety_page.dart
import 'package:flutter/material.dart';

class RoadSafetyPage extends StatelessWidget {
  const RoadSafetyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final carRules = [
      {'rule': 'Always wear seat belts', 'fine': '₹1,000'},
      {'rule': 'Do not use mobile phones while driving', 'fine': '₹5,000'},
      {'rule': 'Follow speed limits', 'fine': '₹1,000 to ₹2,000'},
      {'rule': 'Do not drink and drive', 'fine': '₹10,000 or imprisonment'},
      {'rule': 'Carry valid driving license', 'fine': '₹5,000'},
    ];

    final bikeRules = [
      {'rule': 'Wear helmet at all times', 'fine': '₹1,000'},
      {'rule': 'Do not ride with more than one pillion', 'fine': '₹1,000'},
      {'rule': 'Use proper indicators and mirrors', 'fine': '₹500'},
      {'rule': 'Do not overspeed or stunt ride', 'fine': '₹1,000 to ₹2,000'},
      {'rule': 'Ensure bike insurance and documents are updated', 'fine': '₹2,000'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Road Safety Regulations'),
        backgroundColor: const Color(0xFF4A90E2),
      ),
      backgroundColor: const Color(0xFFF6F7FB),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Car Safety Regulations',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E3A59),
              ),
            ),
            const SizedBox(height: 10),
            ...carRules.map((rule) => _buildRuleCard(rule['rule']!, rule['fine']!)),
            const SizedBox(height: 24),
            const Text(
              'Motorcycle Safety Regulations',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E3A59),
              ),
            ),
            const SizedBox(height: 10),
            ...bikeRules.map((rule) => _buildRuleCard(rule['rule']!, rule['fine']!)),
          ],
        ),
      ),
    );
  }

  Widget _buildRuleCard(String rule, String fine) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: const Icon(Icons.shield, color: Color(0xFF4A90E2), size: 30),
        title: Text(
          rule,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2E3A59),
          ),
        ),
        subtitle: Text(
          'Fine: $fine',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}