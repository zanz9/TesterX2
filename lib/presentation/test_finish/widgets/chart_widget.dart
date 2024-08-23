import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({
    super.key,
    required this.list,
    required this.underText,
    required this.procent,
  });

  final List list;
  final String underText;
  final bool procent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: AspectRatio(
        aspectRatio: 5 / 4,
        child: SizedBox(
          child: LineChart(
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
            LineChartData(
              lineTouchData: const LineTouchData(
                enabled: true,
                touchSpotThreshold: 25,
                touchTooltipData: LineTouchTooltipData(),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  axisNameWidget: Text(underText),
                  axisNameSize: 22,
                  sideTitles: const SideTitles(),
                ),
                topTitles: const AxisTitles(),
                leftTitles: const AxisTitles(),
                rightTitles: const AxisTitles(),
              ),
              gridData: const FlGridData(show: false),
              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  barWidth: 3,
                  curveSmoothness: .25,
                  gradient: LinearGradient(colors: [
                    Colors.black,
                    Colors.grey.shade700,
                    Colors.black,
                    Colors.grey.shade700,
                    Colors.black,
                  ]),
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(show: true),
                  spots: [
                    for (var (k, v) in list.indexed)
                      FlSpot(
                        k.toDouble(),
                        procent
                            ? (v.correct.toDouble() /
                                v.maxScore.toDouble() *
                                100)
                            : v.correct.toDouble(),
                      )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
