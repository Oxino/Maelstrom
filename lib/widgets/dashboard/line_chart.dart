import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
        LineChartData(minX: 0, maxX: 11, minY: 0, maxY: 100, lineBarsData: [
      LineChartBarData(spots: [
        FlSpot(0, 3),
      ]),
    ]));
  }
}
