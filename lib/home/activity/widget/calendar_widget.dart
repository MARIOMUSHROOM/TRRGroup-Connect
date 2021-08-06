// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// class CalendarWidget extends StatelessWidget {
//   const CalendarWidget({
//     Key key,
//     @required this.context,
//     @required DateTime dateNow,
//     @required DateTime focusedDay,
//     @required CalendarFormat calendarFormat,
//     @required DateTime selectedDay,
//     @required this.onTap,
//     this.selectedDayPredicate,
//     this.onDaySelected,
//     this.onPageChanged,
//   })  : _dateNow = dateNow,
//         _focusedDay = focusedDay,
//         _calendarFormat = calendarFormat,
//         _selectedDay = selectedDay,
//         super(key: key);

//   final BuildContext context;
//   final DateTime _dateNow;
//   final DateTime _focusedDay;
//   final CalendarFormat _calendarFormat;
//   final DateTime _selectedDay;
//   final Function() onTap;
//   final bool Function(DateTime) selectedDayPredicate;
//   final Function(DateTime, DateTime) onDaySelected;
//   final Function(DateTime) onPageChanged;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Text("เลือกวันที่"),
//             SizedBox(
//               width: 10,
//             ),
//             GestureDetector(
//               // onTap: () {
//               //   _selectDate(context);
//               // },
//               onTap: onTap,
//               child: Icon(Icons.calendar_today),
//             ),
//           ],
//         ),
//         TableCalendar(
//           firstDay: DateTime(_dateNow.year - 20),
//           lastDay: _dateNow,
//           focusedDay: _focusedDay,
//           calendarFormat: _calendarFormat,
//           selectedDayPredicate: selectedDayPredicate,
//           onDaySelected: onDaySelected,
//           onPageChanged: onPageChanged,
//           // selectedDayPredicate: (day) {
//           //   // Use `selectedDayPredicate` to determine which day is currently selected.
//           //   // If this returns true, then `day` will be marked as selected.

//           //   // Using `isSameDay` is recommended to disregard
//           //   // the time-part of compared DateTime objects.
//           //   return isSameDay(_selectedDay, day);
//           // },
//           // onDaySelected: (selectedDay, focusedDay) {
//           //   if (!isSameDay(_selectedDay, selectedDay)) {
//           //     // Call `setState()` when updating the selected day
//           //     setState(() {
//           //       _selectedDate = selectedDay;
//           //       _selectedDay = selectedDay;
//           //       _focusedDay = focusedDay;
//           //     });
//           //   }
//           // },
//           // // onFormatChanged: (format) {
//           // //   if (_calendarFormat != format) {
//           // //     // Call `setState()` when updating calendar format
//           // //     setState(() {
//           // //       _calendarFormat = format;
//           // //     });
//           // //   }
//           // // },
//           // onPageChanged: (focusedDay) {
//           //   // No need to call `setState()` here
//           //   _focusedDay = focusedDay;
//           // },
//         ),
//       ],
//     );
//   }
// }
