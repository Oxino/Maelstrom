import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maelstrom/config.dart';

import 'package:intl/intl.dart';

class DateTimePicker extends StatefulWidget {
  bool isDate;
  void Function(dynamic) setValue;
  var selectedValue;
  DateTimePicker(this.isDate, this.setValue, this.selectedValue, {Key? key})
      : super(key: key);

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: new BorderRadius.circular(10),
            color: ThemeColors.grayColor),
        height: 40,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
            ),
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Align(
                  alignment: Alignment.center,
                  child: widget.isDate
                      ? Text(
                          widget.selectedValue == null
                              ? "Selectionnez la date de votre évènement"
                              : DateFormat('dd-MM-yyyy')
                                  .format(widget.selectedValue as DateTime),
                          style: TextStyle(color: ThemeColors.whiteColor),
                          textAlign: TextAlign.right)
                      : Text(
                          widget.selectedValue == null
                              ? "Selectionnez l'heure de votre évènement"
                              : "${widget.selectedValue.format(context)}",
                          style: TextStyle(color: ThemeColors.whiteColor),
                          textAlign: TextAlign.right,
                        ),
                )),
            onPressed: () =>
                widget.isDate ? _selectDate(context) : _selectTime(context)));
  }

  _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
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
                      ? ThemeColors.principaleBusinessColor
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
                      ? ThemeColors.principaleBusinessColor
                      : ThemeColors.grayColor),
              hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
                  states.contains(MaterialState.selected)
                      ? ThemeColors.whiteColor
                      : ThemeColors.principaleBusinessColor),
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
                      ? ThemeColors.principaleBusinessColor
                      : ThemeColors.whiteColor),
              entryModeIconColor: ThemeColors.principaleBusinessColor,
            )),
            child: child as Widget,
          );
        });
    if (timeOfDay != null && timeOfDay != widget.selectedValue) {
      widget.setValue(timeOfDay);
    }
  }

  /// This builds material date picker in Android
  buildMaterialDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      helpText: "Selectionnez la date de l'évènement",
      cancelText: 'Annuler',
      confirmText: 'Valider',
      locale: const Locale("fr", "FR"),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            // primaryColor: ThemeColors.backgroundColor,
            colorScheme: ColorScheme.light(
              primary: ThemeColors.principaleBusinessColor,
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
    // setState(() {
    //   widget.selectedValue = picked;
    //   print(widget.selectedValue);
    // });
  }

  /// This builds cupertion date picker in iOS
  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: ThemeColors.backgroundColor,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != null && picked != widget.selectedValue)
                  widget.setValue(picked);
                // setState(() {
                //   widget.selectedValue = picked;
                //   print(widget.selectedValue);
                // });
              },
              initialDateTime: widget.selectedValue,
              minimumYear: 2000,
              maximumYear: 2025,
            ),
          );
        });
  }
}
