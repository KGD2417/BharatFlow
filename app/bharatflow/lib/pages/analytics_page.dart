import 'package:flutter/material.dart';
import '/components/fl_bar.dart';
import '/components/fl_chart.dart';
import '/components/fl_pie.dart';
import 'dart:math' as math;
import 'package:bharatflow/components/chart_container.dart';



class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1100;
    final isTablet = MediaQuery.of(context).size.width >= 650 && MediaQuery.of(context).size.width < 1100;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Traffic Analytics',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Color(0xff0c0c0c),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Analyze traffic patterns and congestion data',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Color(0x6e04063f),
              ),
            ),
            const SizedBox(height: 24),
            // Date Range Selector
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Text(
                      'Date Range:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white.withOpacity(0.1),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: 'Last 7 Days',
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          prefixIcon: Icon(Icons.calendar_today, size: 18),
                          border: InputBorder.none,
                        ),
                        dropdownColor: const Color(0xFF04063f),
                        style: const TextStyle(color: Colors.white),
                        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                        items: [
                          'Today',
                          'Yesterday',
                          'Last 7 Days',
                          'Last 30 Days',
                          'Custom Range',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {},
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.refresh),
                      label: const Text('Export'),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3243f5),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Charts Grid
            SizedBox(
              height: isDesktop ? 400 : (isTablet ? 600 : 900),
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
                    chart: BarChartSample3(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Zone-wise Congestion
            SizedBox(
              height: 400,
              child: ChartContainer(
                title: 'Zone-wise Congestion',
                actions: [
                  TextButton.icon(
                    icon: const Icon(Icons.download, color: Colors.white),
                    label: const Text('Export', style: TextStyle(color: Colors.white)),
                    onPressed: () {},
                  ),
                ],
                chart: PieChartSample2(),
              ),
            ),
            const SizedBox(height: 24),
  //           // Traffic Incidents Table
  //           Card(
  //             elevation: 2,
  //             child: Padding(
  //               padding: const EdgeInsets.all(16),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Row(
  //                     children: [
  //                       const Text(
  //                         'Traffic Incidents',
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 18,
  //                           color: Colors.white,
  //                         ),
  //                       ),
  //                       const Spacer(),
  //                       TextButton.icon(
  //                         icon: const Icon(Icons.filter_list, color: Colors.white),
  //                         label: const Text('Filter', style: TextStyle(color: Colors.white)),
  //                         onPressed: () {},
  //                       ),
  //                     ],
  //                   ),
  //                   const SizedBox(height: 16),
  //                   SingleChildScrollView(
  //                     scrollDirection: Axis.horizontal,
  //                     child: Theme(
  //                       data: Theme.of(context).copyWith(
  //                         dataTableTheme: const DataTableThemeData(
  //                           headingTextStyle: TextStyle(
  //                             color: Colors.white,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                           dataTextStyle: TextStyle(
  //                             color: Colors.white,
  //                           ),
  //                         ),
  //                       ),
  //                       child: DataTable(
  //                         columns: const [
  //                           DataColumn(label: Text('Time')),
  //                           DataColumn(label: Text('Location')),
  //                           DataColumn(label: Text('Type')),
  //                           DataColumn(label: Text('Severity')),
  //                           DataColumn(label: Text('Status')),
  //                         ],
  //                         rows: [
  //                           _buildDataRow('08:30 AM', 'Main St & 5th Ave', 'Accident', 'High', 'Resolved'),
  //                           _buildDataRow('10:15 AM', 'Broadway & 42nd St', 'Construction', 'Medium', 'Ongoing'),
  //                           _buildDataRow('12:45 PM', 'Park Ave & 23rd St', 'Signal Failure', 'High', 'In Progress'),
  //                           _buildDataRow('03:20 PM', 'West Blvd & Oak St', 'Congestion', 'Medium', 'Monitoring'),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
          // Traffic Incidents Table
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
                  Row(
                    children: [
                      const Text(
                        'Traffic Incidents',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
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
                    ],
                  ),
                  const SizedBox(height: 24),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        dataTableTheme: DataTableThemeData(
                          headingRowColor: MaterialStateProperty.all(Colors.blueGrey[800]),
                          dataRowColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors.blue.withOpacity(0.3);
                            }
                            return Colors.blueGrey[900];
                          }),
                          headingTextStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          dataTextStyle: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                          dividerThickness: 0.8,
                        ),
                      ),
                      child: DataTable(
                        border: TableBorder(
                          horizontalInside: BorderSide(color: Colors.white12, width: 1),
                        ),
                        columnSpacing: 24,
                        columns: const [
                          DataColumn(label: Text('Time')),
                          DataColumn(label: Text('Location')),
                          DataColumn(label: Text('Type')),
                          DataColumn(label: Text('Severity')),
                          DataColumn(label: Text('Status')),
                        ],
                        rows: [
                          _buildDataRow('08:30 AM', 'Main St & 5th Ave', 'Accident', 'High', 'Resolved'),
                          _buildDataRow('10:15 AM', 'Broadway & 42nd St', 'Construction', 'Medium', 'Ongoing'),
                          _buildDataRow('12:45 PM', 'Park Ave & 23rd St', 'Signal Failure', 'High', 'In Progress'),
                          _buildDataRow('03:20 PM', 'West Blvd & Oak St', 'Congestion', 'Medium', 'Monitoring'),
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

          static DataRow _buildDataRow(String time, String location, String type, String severity, String status) {
    Color severityColor = switch (severity) {
      'High' => Colors.red,
      'Medium' => Colors.orange,
      _ => Colors.green,
    };

    return DataRow(
      cells: [
        DataCell(Text(time)),
        DataCell(Text(location)),
        DataCell(Text(type)),
        DataCell(Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: severityColor, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Text(severity),
          ],
        )),
        DataCell(Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: status == 'Resolved'
                ? Colors.green.withOpacity(0.2)
                : (status == 'In Progress'
                ? Colors.blue.withOpacity(0.2)
                : Colors.orange.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: status == 'Resolved'
                  ? Colors.green
                  : (status == 'In Progress' ? Colors.blue : Colors.orange),
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildLineChartPlaceholder(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: CustomPaint(
        painter: LineChartPainter(),
        size: const Size(double.infinity, double.infinity),
      ),
    );
  }

  Widget _buildBarChartPlaceholder(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: CustomPaint(
        painter: BarChartPainter(),
        size: const Size(double.infinity, double.infinity),
      ),
    );
  }

  Widget _buildPieChartPlaceholder(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: CustomPaint(
        painter: PieChartPainter(),
        size: const Size(double.infinity, double.infinity),
      ),
    );
  }
}

class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF3243f5)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.6);

    for (int i = 1; i <= 10; i++) {
      final x = size.width * (i / 10);
      final y = size.height * (0.2 + 0.6 * (0.5 - 0.5 * math.sin(i * 0.5)));
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);

    final axisPaint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..strokeWidth = 1;

    for (int i = 1; i <= 5; i++) {
      final y = size.height * (i / 6);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), axisPaint);
    }

    final textStyle = const TextStyle(color: Colors.black54, fontSize: 10);
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct'];
    for (int i = 0; i < months.length; i++) {
      textPainter.text = TextSpan(text: months[i], style: textStyle);
      textPainter.layout();
      final x = size.width * ((i + 0.5) / months.length) - textPainter.width / 2;
      textPainter.paint(canvas, Offset(x, size.height - textPainter.height));
    }

    final tooltipPoint = Offset(size.width * 0.5, size.height * 0.3);
    canvas.drawCircle(tooltipPoint, 5, Paint()..color = const Color(0xFF3243f5));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final barWidth = size.width / 21;
    final spacing = barWidth * 0.2;
    final effectiveBarWidth = barWidth - spacing;
    final groupSpacing = barWidth * 0.5;

    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 1;

    for (int i = 1; i <= 5; i++) {
      final y = size.height * (1 - i / 6) - 20;
      canvas.drawLine(Offset(40, y), Offset(size.width, y), gridPaint);

      final textStyle = const TextStyle(color: Colors.black54, fontSize: 10);
      final textPainter = TextPainter(textDirection: TextDirection.ltr);
      textPainter.text = TextSpan(text: '${i * 200}K', style: textStyle);
      textPainter.layout();
      textPainter.paint(canvas, Offset(5, y - textPainter.height / 2));
    }

    // Add your bar drawing logic here
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PieChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 3;

    final colors = [Colors.blue, Colors.green, Colors.orange, Colors.red];
    final values = [0.3, 0.2, 0.25, 0.25];
    double startRadian = -math.pi / 2;

    for (int i = 0; i < values.length; i++) {
      final sweepRadian = values[i] * 2 * math.pi;
      paint.color = colors[i];
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startRadian, sweepRadian, true, paint);
      startRadian += sweepRadian;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
