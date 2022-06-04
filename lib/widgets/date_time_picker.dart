import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maelstrom/bloc/application_bloc.dart';
import 'package:maelstrom/bloc/bloc_provider.dart';
import 'package:maelstrom/config.dart';

import 'package:intl/intl.dart';
import 'package:maelstrom/widgets/base_text.dart';

class DateTimePicker extends StatefulWidget {
  bool isDate;
  void Function(dynamic) setValue;
  var selectedValue;
  final String text;
  final Color color;
  final int startDate;
  final int endDate;

  DateTimePicker(
    this.isDate,
    this.setValue,
    this.selectedValue,
    this.text,
    this.color, {
    Key? key,
    int this.startDate = 2022,
    int this.endDate = 2050,
  }) : super(key: key);

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () =>
            widget.isDate ? _selectDate(context) : _selectTime(context),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: new BorderRadius.circular(10),
                color: ThemeColors.grayColor),
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.isDate
                    ? BaseText(
                        TextType.bodyText,
                        widget.selectedValue == null
                            ? widget.text
                            : DateFormat('dd-MM-yyyy')
                                .format(widget.selectedValue as DateTime),
                        textColor: widget.selectedValue == null
                            ? ThemeColors.textUnfocusColor
                            : ThemeColors.whiteColor)
                    : BaseText(
                        TextType.bodyText,
                        widget.selectedValue == null
                            ? widget.text
                            : "${widget.selectedValue.format(context)}",
                        textColor: widget.selectedValue == null
                            ? ThemeColors.textUnfocusColor
                            : ThemeColors.whiteColor),
                SizedBox(
                  height: 20, // Your Height
                  width: 20,
                  child: widget.isDate
                      ? SvgPicture.asset(
                          'assets/icons/calendar.svg',
                          color: widget.selectedValue == null
                              ? ThemeColors.textUnfocusColor
                              : ThemeColors.whiteColor,
                        )
                      : SvgPicture.asset(
                          'assets/icons/time.svg',
                          color: widget.selectedValue == null
                              ? ThemeColors.textUnfocusColor
                              : ThemeColors.whiteColor,
                        ),
                ),
              ],
            )));
  }

  _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(widget.startDate),
      lastDate: DateTime(widget.endDate),
      helpText: "Selectionnez la date de l'évènement",
      cancelText: 'Annuler',
      confirmText: 'Valider',
      locale: const Locale("fr", "FR"),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            // primaryColor: ThemeColors.backgroundColor,
            colorScheme: ColorScheme.light(
              primary: widget.color,
              onPrimary: ThemeColors.whiteColor,
              onSurface: ThemeColors.whiteColor,
            ),
            dialogBackgroundColor: ThemeColors.backgroundColor,
          ),
          child: child as Widget,
        );
      },
    );
    if (picked != null && picked != widget.selectedValue)
      widget.setValue(picked);
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.dial,
        helpText: "Selectionnez l'heure de l'évènement",
        cancelText: 'Annuler',
        confirmText: 'Valider',
        builder: (context, child) {
          return Theme(
            // ThemeColors.grayColor
            data: ThemeData(
                timePickerTheme: TimePickerThemeData(
              backgroundColor: ThemeColors.backgroundColor,
              hourMinuteShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              dayPeriodBorderSide:
                  const BorderSide(color: Colors.transparent, width: 0),
              dayPeriodColor: MaterialStateColor.resolveWith((states) =>
                  states.contains(MaterialState.selected)
                      ? widget.color
                      : ThemeColors.grayColor),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              dayPeriodTextColor: ThemeColors.whiteColor,
              dayPeriodShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              hourMinuteColor: MaterialStateColor.resolveWith((states) =>
                  states.contains(MaterialState.selected)
                      ? widget.color
                      : ThemeColors.grayColor),
              hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
                  states.contains(MaterialState.selected)
                      ? ThemeColors.whiteColor
                      : widget.color),
              dialHandColor: Colors.blueGrey.shade700,
              dialBackgroundColor: ThemeColors.grayColor,
              hourMinuteTextStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              dayPeriodTextStyle:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              helpTextStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.whiteColor),
              inputDecorationTheme: const InputDecorationTheme(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(0),
              ),
              dialTextColor: MaterialStateColor.resolveWith((states) =>
                  states.contains(MaterialState.selected)
                      ? widget.color
                      : ThemeColors.whiteColor),
              entryModeIconColor: widget.color,
            )),
            child: child as Widget,
          );
        });
    if (timeOfDay != null && timeOfDay != widget.selectedValue) {
      widget.setValue(timeOfDay);
    }
  }
}
