// import 'package:flutter/material.dart';
// import 'package:numberpicker/numberpicker.dart';

// class CustomYearPickerWidget extends StatefulWidget {
//   final ValueChanged<int> startTime;
//   final ValueChanged<int> lastTime;
//   CustomYearPickerWidget({Key key, this.startTime, this.lastTime})
//       : super(key: key);
//   @override
//   _CustomYearPickerWidgetState createState() => _CustomYearPickerWidgetState();
// }

// class _CustomYearPickerWidgetState extends State<CustomYearPickerWidget> {
//   int thaiFormYear = DateTime.now().year + 543;
//   int startYearNew;
//   int lastYearNew;

//   validateData(int start, int last) {
//     if (start > last) {
//       setState(() {
//         lastYearNew = start;
//       });
//     } else {
//       setState(() {
//         startYearNew = start;
//         lastYearNew = last;
//       });
//     }
//   }

//   setData() {
//     startYearNew = thaiFormYear - 1;
//     lastYearNew = thaiFormYear - 1;
//   }

//   @override
//   void initState() {
//     setData();
//     super.initState();
//   }

//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment(0, 0),
//       child: Material(
//         color: Colors.transparent,
//         child: Container(
//           height: 300,
//           width: 380,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           padding: EdgeInsets.all(8),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 height: 30,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: Offset(0, 3), // changes position of shadow
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                         child: Text(
//                       "$startYearNew",
//                       textAlign: TextAlign.center,
//                     )),
//                     Expanded(
//                         child: Text(
//                       "$lastYearNew",
//                       textAlign: TextAlign.center,
//                     )),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 height: 150,
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: NumberPicker(
//                         value: startYearNew,
//                         minValue: thaiFormYear - 20,
//                         maxValue: thaiFormYear - 1,
//                         step: 1,
//                         haptics: true,
//                         itemCount: 5,
//                         itemHeight: 30,
//                         onChanged: (value) {
//                           validateData(value, lastYearNew);
//                         },
//                       ),
//                     ),
//                     Expanded(
//                       child: NumberPicker(
//                         value: lastYearNew,
//                         minValue: startYearNew,
//                         maxValue: thaiFormYear,
//                         step: 1,
//                         haptics: true,
//                         itemCount: 5,
//                         itemHeight: 30,
//                         // onChanged: onChanged2,
//                         onChanged: (value) {
//                           validateData(startYearNew, value);
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               FlatButton(
//                 onPressed: () {
//                   widget.startTime(startYearNew);
//                   widget.lastTime(lastYearNew);
//                   Navigator.pop(context);
//                 },
//                 child: Container(
//                   width: 320,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset: Offset(0, 3), // changes position of shadow
//                       ),
//                     ],
//                   ),
//                   alignment: Alignment.center,
//                   child: Text("เสร็จสิ้น"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
