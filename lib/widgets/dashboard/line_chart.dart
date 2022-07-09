import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maelstrom/config.dart';
import 'package:maelstrom/widgets/base_text.dart';

class LineChartBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.23,
        child: Container(
            padding: EdgeInsets.only(left: 8, top: 8, right: 18, bottom: 8),
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
                    'assets/icons/data_user.svg',
                  )),
            ),
            
                BaseText(TextType.bigText, "Inscrits sur l'app"),
          ],
        ),
                SizedBox(height: 20),
                Expanded(
                  child: LineChartWidget(),
                )
              ],
            )));
  }
}

class LineChartWidget extends StatelessWidget {
  Gradient lineGradient = LinearGradient(colors: [
    ThemeColors.radientBusinessColor,
    ThemeColors.principaleBusinessColor
  ]);
  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
        minX: 1,
        maxX: 13,
        minY: 0,
        maxY: 5,
        titlesData: titlesData,
        borderData: borderData,
        gridData: FlGridData(show: false),
        lineBarsData: lineBarsData));
  }

  List<LineChartBarData> get lineBarsData => [
        LineChartBarData(
          spots: [
            FlSpot(1, 1.7),
            FlSpot(3, 1.9),
            FlSpot(5, 2.3),
            FlSpot(7, 2.8),
            FlSpot(9, 3.1),
            FlSpot(12, 4),
          ],
          isStrokeCapRound: true,
          isCurved: true,
          gradient: lineGradient,
          dotData: FlDotData(show: false),
          barWidth: 6,
          belowBarData: BarAreaData(show: false),
        ),
      ];

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: ThemeColors.whiteColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('JUI', style: style);
        break;
      case 7:
        text = const Text('DEC', style: style);
        break;
      case 12:
        text = const Text('JIN', style: style);
        break;
      default:
        text = const Text('');
        break;
    }
    ;
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: ThemeColors.whiteColor,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1k';
        break;
      case 2:
        text = '2k';
        break;
      case 3:
        text = '3k';
        break;
      case 4:
        text = '4k';
        break;
      case 5:
        text = '5k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: ThemeColors.whiteColor, width: 4),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );
}
