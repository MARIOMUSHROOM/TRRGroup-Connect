// import 'package:ai_flutter/chat/audio_message.dart';
// import 'package:ai_flutter/chat/chat_message_type.dart';
// import 'package:ai_flutter/chat/text_message.dart';
// import 'package:ai_flutter/chat/video_message.dart';
// import 'package:ai_flutter/theme/constants.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Message extends StatelessWidget {
//   const Message({
//     Key key,
//     @required this.message,
//   }) : super(key: key);

//   final ChatMessage message;

//   @override
//   Widget build(BuildContext context) {
//     Widget messageContaint(ChatMessage message) {
//       switch (message.messageType) {
//         case ChatMessageType.text:
//           return TextMessage(message: message);
//           break;
//         // case ChatMessageType.audio:
//         //   return AudioMessage(message: message);
//         //   break;
//         // case ChatMessageType.video:
//         //   return VideoMessage(message: message);
//         //   break;
//         default:
//           return SizedBox();
//       }
//     }

//     return Padding(
//       padding: const EdgeInsets.only(top: kDefaultPadding),
//       child: Row(
//         mainAxisAlignment:
//             message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
//         children: [
//           if (!message.isSender) ...[
//             CircleAvatar(
//               radius: 12,
//               backgroundImage: AssetImage("assets/images/avatar/user_01.png"),
//             ),
//             SizedBox(
//               width: kDefaultPadding / 2,
//             )
//           ],
//           messageContaint(message),
//           if (message.isSender)
//             Container(
//               padding: EdgeInsets.only(left: 5.0, top: 0.0),
//               child: Column(
//                 children: [
//                   MessageStatusDot(status: message.messageStatus),
//                   Text(
//                     message.time,
//                     style: GoogleFonts.kanit(
//                         fontSize: 12.0,
//                         fontWeight: FontWeight.w400,
//                         textStyle: TextStyle(color: kPrimaryColor)),
//                   ),
//                 ],
//               ),
//             ),
//           if (!message.isSender)
//             Container(
//               padding: EdgeInsets.only(left: 5.0),
//               child: Column(
//                 children: [
//                   Text(
//                     message.time,
//                     style: GoogleFonts.kanit(
//                         fontSize: 12.0,
//                         fontWeight: FontWeight.w400,
//                         textStyle: TextStyle(color: kPrimaryColor)),
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// class MessageStatusDot extends StatelessWidget {
//   final MessageStatus status;

//   const MessageStatusDot({Key key, this.status}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     Color dotColor(MessageStatus status) {
//       switch (status) {
//         case MessageStatus.not_sent:
//           return kErrorColor;
//           break;
//         case MessageStatus.not_view:
//           return Theme.of(context).textTheme.bodyText1.color.withOpacity(0.1);
//           break;
//         case MessageStatus.viewed:
//           return kPrimaryColor;
//           break;
//         default:
//           return Colors.transparent;
//       }
//     }

//     return Column(
//       children: [
//         if (status == MessageStatus.not_sent)
//           Container(
//             // margin: EdgeInsets.only(left: kDefaultPadding / 2),
//             height: 16.0,
//             width: 16.0,
//             decoration:
//                 BoxDecoration(color: dotColor(status), shape: BoxShape.circle),
//             child: Icon(Icons.error_rounded,
//                 size: 14.0, color: Theme.of(context).scaffoldBackgroundColor),
//           ),
//         if (status != MessageStatus.not_sent)
//           Container(
//             child: Text(
//               status == MessageStatus.not_view ? 'ยังไม่อ่าน' : 'อ่านแล้ว',
//               style: GoogleFonts.kanit(
//                   fontSize: 12.0,
//                   fontWeight: FontWeight.w600,
//                   textStyle: TextStyle(color: kPrimaryColor)),
//             ),
//           ),
//       ],
//     );

//     // Text(
//     //   message,
//     //   style: GoogleFonts.kanit(
//     //       fontSize: 12.0,
//     //       fontWeight: FontWeight.w600,
//     //       textStyle: TextStyle(color: kPrimaryColor)),
//     // ),

//     // return Column(
//     //   children: [
//     //     Container(
//     //       margin: EdgeInsets.only(left: kDefaultPadding / 2),
//     //       height: 16.0,
//     //       width: 16.0,
//     //       decoration:
//     //           BoxDecoration(color: dotColor(status), shape: BoxShape.circle),
//     //       child: Icon(
//     //           status == MessageStatus.not_sent
//     //               ? Icons.error_rounded
//     //               : Icons.done,
//     //           size: 14.0,
//     //           color: Theme.of(context).scaffoldBackgroundColor),
//     //     ),
//     //   ],
//     // );
//   }
// }
