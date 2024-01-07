import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartGenerator {
  Widget generatePieChart(Map<String, int> statusCounts) {
    List<PieChartSectionData> sections = statusCounts.entries.map((entry) {
      return PieChartSectionData(
        value: entry.value.toDouble(),
        color: entry.key == 'Approved' ? Colors.greenAccent : Colors.yellow,
        title: '${entry.key}: ${entry.value}',
        radius: 50,
      );
    }).toList();

    return PieChart(
      PieChartData(
        sections: sections,
        // Other configurations for the pie chart
      ),
    );
  }
}
