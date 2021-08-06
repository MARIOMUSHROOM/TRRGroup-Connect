// import 'package:ai_flutter/theme/constants.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class ChatInputField extends StatelessWidget {
//   const ChatInputField({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//           horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
//       decoration: BoxDecoration(
//           color: Theme.of(context).scaffoldBackgroundColor,
//           boxShadow: [
//             BoxShadow(
//                 offset: Offset(0, 6), blurRadius: 12.0, color: kPrimaryColor)
//           ]),
//       child: SafeArea(
//         child: Row(
//           children: [
//             // Icon(Icons.mic_none_outlined,
//             //     color: Theme.of(context)
//             //         .textTheme
//             //         .bodyText1
//             //         .color
//             //         .withOpacity(0.64)),
//             // SizedBox(
//             //   width: kDefaultPadding,
//             // ),
//             Expanded(
//               flex: 7,
//               child: Container(
//                 height: 50,
//                 decoration: BoxDecoration(
//                   color: kPrimaryColor.withOpacity(0.05),
//                   borderRadius: BorderRadius.circular(40.0),
//                 ),
//                 child: Row(
//                   children: [
//                     // Icon(
//                     //   Icons.sentiment_dissatisfied_outlined,
//                     //   color: Theme.of(context)
//                     //       .textTheme
//                     //       .bodyText1
//                     //       .color
//                     //       .withOpacity(0.64),
//                     // ),
//                     SizedBox(
//                       width: kDefaultPadding / 4,
//                     ),
//                     Expanded(
//                         child: TextField(
//                       decoration: InputDecoration(
//                         hintText: "กรอกข้อความ",
//                         border: InputBorder.none,
//                       ),
//                     )),
//                     // Icon(
//                     //   Icons.attach_file,
//                     //   color: Theme.of(context)
//                     //       .textTheme
//                     //       .bodyText1
//                     //       .color
//                     //       .withOpacity(0.64),
//                     // ),
//                     // Icon(
//                     //   Icons.camera_alt_outlined,
//                     //   color: Theme.of(context)
//                     //       .textTheme
//                     //       .bodyText1
//                     //       .color
//                     //       .withOpacity(0.64),
//                     // ),
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 3,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.camera_alt_outlined,
//                     color: Theme.of(context)
//                         .textTheme
//                         .bodyText1
//                         .color
//                         .withOpacity(0.64),
//                     size: 35,
//                   ),
//                   Icon(
//                     Icons.image_outlined,
//                     color: Theme.of(context)
//                         .textTheme
//                         .bodyText1
//                         .color
//                         .withOpacity(0.64),
//                     size: 35,
//                   ),
//                   Icon(
//                     Icons.send_rounded,
//                     color: Theme.of(context)
//                         .textTheme
//                         .bodyText1
//                         .color
//                         .withOpacity(0.64),
//                     size: 35,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
