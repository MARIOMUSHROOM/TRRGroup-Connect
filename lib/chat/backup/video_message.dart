// import 'package:ai_flutter/chat/chat_message_type.dart';
// import 'package:ai_flutter/theme/constants.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class VideoMessage extends StatelessWidget {
//   final ChatMessage message;

//   const VideoMessage({Key key, this.message}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width * 0.45,
//       child: AspectRatio(
//         aspectRatio: 1.6,
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8.0),
//               child: Image.asset("assets/images/message/default_video.png"),
//             ),
//             Container(
//               height: 25.0,
//               width: 25.0,
//               decoration: BoxDecoration(
//                 color: kPrimaryColor,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Icons.play_arrow,
//                 size: 16,
//                 color: Colors.white,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
