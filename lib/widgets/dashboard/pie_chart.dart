import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:maelstrom/config.dart';
import 'package:maelstrom/widgets/base_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maelstrom/widgets/tags_widget.dart';

class PieChartBlock extends StatefulWidget {
  const PieChartBlock({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChartBlockState();
}

class PieChartBlockState extends State {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.05,
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
                          'assets/icons/data_tag.svg',
                        )),
                  ),
                  BaseText(TextType.bigText, "Utilisation des tags"),
                ],
              ),
              SizedBox(height: 30),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                        pieTouchData: PieTouchData(touchCallback:
                            (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        }),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingSections()),
                  ),
                ),
              ),
               SizedBox(
                height: 30,
              ),
            ],
          ),
        ));
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(5, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      final widgetSize = isTouched ? 100.0 : 80.0;

      TextStyle numberStyle = TextStyle(
        fontFamily: 'Dosis',
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: ThemeColors.whiteColor,
      );
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: TagsColors.purpleTag,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: numberStyle,
            badgeWidget: isTouched
                ? _Badge('Jeux-vidéo',
                    size: widgetSize, color: TagsColors.purpleTag)
                : null,
            badgePositionPercentageOffset: 1.4,
          );
        case 1:
          return PieChartSectionData(
            color: TagsColors.redTag,
            value: 25,
            title: '25%',
            radius: radius,
            titleStyle: numberStyle,
            badgeWidget: isTouched
                ? _Badge('Jeux', size: widgetSize, color: TagsColors.redTag)
                : null,
            badgePositionPercentageOffset: 1.4,
          );
        case 2:
          return PieChartSectionData(
            color: TagsColors.blueTag,
            value: 10,
            title: '10%',
            radius: radius,
            titleStyle: numberStyle,
            badgeWidget: isTouched
                ? _Badge('Quizz', size: widgetSize, color: TagsColors.blueTag)
                : null,
            badgePositionPercentageOffset: 1.4,
          );
        case 3:
          return PieChartSectionData(
            color: TagsColors.greenTag,
            value: 10,
            title: '10%',
            radius: radius,
            titleStyle: numberStyle,
            badgeWidget: isTouched
                ? _Badge('Promo', size: widgetSize, color: TagsColors.greenTag)
                : null,
            badgePositionPercentageOffset: 1.4,
          );
        case 4:
          return PieChartSectionData(
            color: ThemeColors.textUnfocusColor,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: numberStyle,
            badgeWidget: isTouched
                ? _Badge('Autres',
                    size: widgetSize, color: ThemeColors.textUnfocusColor)
                : null,
            badgePositionPercentageOffset: 1.6,
          );
        default:
          throw Error();
      }
    });
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final double size;
  final Color color;

  const _Badge(
    this.text, {
    Key? key,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      child: Center(child: TagsWidget(TagsType.medium, text, color)),
    );
  }
}
