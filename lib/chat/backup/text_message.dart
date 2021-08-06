// import 'package:ai_flutter/chat/chat_message_type.dart';
// import 'package:ai_flutter/theme/constants.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class TextMessage extends StatelessWidget {
//   const TextMessage({
//     Key key,
//     this.message,
//   }) : super(key: key);

//   final ChatMessage message;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.symmetric(
//             horizontal: kDefaultPadding * 0.75,
//             vertical: kDefaultPadding / 2,
//           ),
//           decoration: BoxDecoration(
//               color: kPrimaryColor.withOpacity(message.isSender ? 1 : 0.08),
//               borderRadius: BorderRadius.circular(30.0)),
//           child: Text(
//             message.text,
//             style: GoogleFonts.kanit(
//                 fontSize: 14.0,
//                 fontWeight: FontWeight.w500,
//                 textStyle: TextStyle(
//                     color: message.isSender
//                         ? Colors.white
//                         : Theme.of(context).textTheme.bodyText1.color)),
//           ),
//         ),
//       ],
//     );
//   }
// }
