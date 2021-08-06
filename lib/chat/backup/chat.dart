// import 'package:ai_flutter/chat/chat_input_field.dart';
// import 'package:ai_flutter/chat/chat_message.dart';
// import 'package:ai_flutter/chat/chat_message_type.dart';
// import 'package:ai_flutter/theme/constants.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ChatPage extends StatelessWidget {
//   static Route<dynamic> route() => MaterialPageRoute(
//         builder: (context) => ChatPage(),
//       );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             centerTitle: true,
//             title: Text(
//               "TRR Group",
//               style: GoogleFonts.montserrat(
//                   fontSize: 27.0,
//                   fontWeight: FontWeight.w600,
//                   textStyle: TextStyle(color: Colors.white)),
//             ),
//             backgroundColor: kPrimaryColor),
//         body: Column(
//           children: [
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: kDefaultPadding,
//                 ),
//                 child: Scrollbar(
//                   child: ListView.builder(
//                     itemCount: demoChatMessages.length,
//                     itemBuilder: (context, index) => Container(
//                         margin: EdgeInsets.only(bottom: 25.0,right: 10.0),
//                         child: Message(message: demoChatMessages[index])),
//                   ),
//                 ),
//               ),
//             ),
//             // SizedBox(height: 30),
//             ChatInputField(),
//           ],
//         ));
//   }
// }
