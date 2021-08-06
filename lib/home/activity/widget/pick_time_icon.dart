import 'dart:ui';

import 'package:ai_flutter/home/activity/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PickTimeIcon extends StatelessWidget {
  final DateTime startDate;
  final ValueChanged<DateTime> focusedDay;

  PickTimeIcon({
    Key key,
    @required this.startDate,
    this.focusedDay,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectDate(context);
      },
      child: Container(
        width: 120,
        alignment: Alignment.center,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: kGoldColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat.yMMM('th_TH').format(startDate),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Image.asset(
              "assets/images/landing/calendar.png",
              scale: 0.8,
              color: Colors.white,
            ),
            // Icon(
            //   Icons.calendar_today,
            //   color: Colors.white,
            // ),
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: startDate != null ? startDate : DateTime.now(),
        firstDate: DateTime(startDate.year - 20),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.blue,
                onPrimary: Colors.white,
                surface: Colors.grey,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      focusedDay(newSelectedDate);
    }
  }
}
