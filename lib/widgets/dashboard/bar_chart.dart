import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maelstrom/config.dart';
import 'package:maelstrom/widgets/base_text.dart';

class BarChartBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.7,
        child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: ThemeColors.grayColor,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: SizedBox(
                          height: 30, // Your Height
                          width: 30,
                          child: SvgPicture.asset(
                            'assets/icons/data_event.svg',
                          )),
                    ),
                    BaseText(TextType.bigText, "Evénements par mois"),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: BarChartWidget(),
                ),
              ],
            )));
  }
}

class BarChartWidget extends StatelessWidget {
  BarChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<double> nbEventByMonth = [
      8,
      10,
      14,
      15,
      13,
      16,
      2,
      0,
      0,
      0,
      0,
      0
    ];
    int count = 0;

    final List<BarChartGroupData>? items =
        nbEventByMonth.map((e) => makeGroupData(count++, e)).toList();
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        barGroups: items,
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      fontFamily: 'Dosis',
      color: ThemeColors.whiteColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'J';
        break;
      case 1:
        text = 'F';
        break;
      case 2:
        text = 'M';
        break;
      case 3:
        text = 'A';
        break;
      case 4:
        text = 'M';
        break;
      case 5:
        text = 'J';
        break;
      case 6:
        text = 'J';
        break;
      case 7:
        text = 'A';
        break;
      case 8:
        text = 'S';
        break;
      case 9:
        text = 'O';
        break;
      case 10:
        text = 'N';
        break;
      case 11:
        text = 'D';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4.0,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  final _barsGradient = const LinearGradient(
    colors: [
      ThemeColors.radientBusinessColor,
      ThemeColors.principaleBusinessColor,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          gradient: _barsGradient,
        ),
      ],
      showingTooltipIndicators: [0],
    );
  }
}
