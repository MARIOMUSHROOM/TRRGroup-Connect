import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../global_const.dart' as cons;

class CustomYearPickerWidget extends StatefulWidget {
  final ValueChanged<DateTime> focusedDay;
  CustomYearPickerWidget({Key key, this.focusedDay}) : super(key: key);
  @override
  _CustomYearPickerWidgetState createState() => _CustomYearPickerWidgetState();
}

class _CustomYearPickerWidgetState extends State<CustomYearPickerWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime _dateNow = DateTime.now();
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("เลือกวันที่"),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                _selectDate(context);
                // widget.focusedDay(_focusedDay);
              },
              child: Icon(Icons.calendar_today),
            ),
          ],
        ),
        TableCalendar(
          firstDay: DateTime(_dateNow.year - 20),
          lastDay: _dateNow,
          focusedDay: _focusedDay,
          // locale: Localizations.localeOf(context).languageCode,
          locale: 'th_TH',
          calendarFormat: CalendarFormat.month,
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
          ),
          selectedDayPredicate: (day) {
            return isSameDay(_focusedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_focusedDay, selectedDay)) {
              setState(() {
                // _selectedDay = selectedDay;
                _focusedDay = selectedDay;
              });
              widget.focusedDay(_focusedDay);
            }
          },
        ),
      ],
    );
  }

  Theme _calendarTheme(Widget child) {
    return Theme(
      child: child,
      data: ThemeData.light().copyWith(
        colorScheme: ColorScheme.light(
          primary: cons.kGoldColor,
          surface: cons.kGoldColor,
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _focusedDay != null ? _focusedDay : _dateNow,
        firstDate: DateTime(_dateNow.year - 20),
        lastDate: _dateNow,
        locale: const Locale('th', 'TH'),
        builder: (BuildContext context, Widget child) {
          return _calendarTheme(child);
          // return Theme(
          //   data: ThemeData.dark().copyWith(
          //     colorScheme: ColorScheme.dark(
          //       primary: Colors.blue,
          //       onPrimary: Colors.white,
          //       surface: Colors.grey,
          //       onSurface: Colors.black,
          //     ),
          //     dialogBackgroundColor: Colors.white,
          //   ),
          //   child: child,
          // );
        });

    if (newSelectedDate != null) {
      setState(() {
        // _selectedDay = newSelectedDate;
        _focusedDay = newSelectedDate;
        widget.focusedDay(_focusedDay);
      });
      // widget.focusedDay(_focusedDay);
    }
  }
}
