// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:circular_profile_avatar/circular_profile_avatar.dart';

// class ProfilePage extends StatelessWidget {
//   static Route<dynamic> route() => MaterialPageRoute(
//         builder: (context) => ProfilePage(),
//       );

//   // const topBG = Color(0xFF32516B);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(245, 241, 242, 1.0),
//       body: SingleChildScrollView(
//         child: Stack(
//           children: <Widget>[
//             ClipPath(
//               clipper: MyProfileClipper(),
//               child: Container(
//                 height: 400.0,
//                 // color: Color.fromRGBO(50, 81, 107, 1),
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     colorFilter: ColorFilter.mode(
//                         Color.fromRGBO(32, 51, 68, 1.0).withOpacity(0.85),
//                         BlendMode.srcOver),
//                     image: NetworkImage(
//                         "https://w7.pngwing.com/pngs/669/568/png-transparent-moriko-recovery-of-an-mmo-junkie-anime-discord-discord-avatar-purple-child-black-hair.png"),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             Align(
//               child: Column(
//                 children: <Widget>[
//                   Padding(padding: EdgeInsets.only(top: 100.0)),
//                   Text(
//                     "Sophia Dio",
//                     style: GoogleFonts.kanit(
//                         fontSize: 30.0,
//                         fontWeight: FontWeight.w600,
//                         textStyle: TextStyle(color: Colors.white)),
//                   ),
//                   Padding(padding: EdgeInsets.only(top: 30.0)),
//                   Text(
//                     "sophia.dio@gmail.com",
//                     style: GoogleFonts.kanit(
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.w300,
//                         textStyle: TextStyle(color: Colors.white70)),
//                   ),
//                   Text(
//                     "090-910-8540",
//                     style: GoogleFonts.kanit(
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.w300,
//                         textStyle: TextStyle(color: Colors.white70)),
//                   ),
//                   Padding(padding: EdgeInsets.only(top: 35.0)),
//                   CircularProfileAvatar(
//                     "https://w7.pngwing.com/pngs/669/568/png-transparent-moriko-recovery-of-an-mmo-junkie-anime-discord-discord-avatar-purple-child-black-hair.png",
//                     borderColor: Colors.white60,
//                     borderWidth: 3.0,
//                     elevation: 5,
//                     radius: 75,
//                     cacheImage: true,
//                   ),
//                   BuildListField(
//                       Icons.person_outline, 'โปรไฟล์', 'purple', () => {}),
//                   BuildListField(Icons.assignment_ind_outlined, 'บัญชี',
//                       'green', () => {}),
//                   BuildListField(
//                       Icons.alarm_outlined, 'การแจ้งเตือน', 'red', () => {}),
//                   // buildTextField('ชื่อ - นามสกุล', 'Icon.person', false),
//                   // buildTextField('อีเมล', 'Icon.person', false),
//                   // buildTextField('เบอร์โทร', 'Icon.person', false),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// //Widget buildTextField(String labelText, String placeholder, bool isPassword) {
// //return Positioned(
// //  child: Container(
// //   padding: EdgeInsets.all(10.0),
// //      child: Padding(
// //        padding: EdgeInsets.all(15.0),
// //        child: TextField(
// //          obscureText: isPassword,
// //          decoration: InputDecoration(
// //              contentPadding: EdgeInsets.only(bottom: 3.0),
// //              labelText: labelText,
// //              floatingLabelBehavior: FloatingLabelBehavior.auto,
// //              labelStyle:
// //              TextStyle(fontWeight: FontWeight.w400, fontSize: 22.0),
// //              hintText: placeholder,
// //              hintStyle:
// //              TextStyle(fontWeight: FontWeight.w300, fontSize: 22.0)),
// //        ),
// //      ),
// //    ),
// //  );
// //}
// //}

// // ignore: must_be_immutable
// class BuildListField extends StatelessWidget {
//   IconData icon;
//   String text;
//   String colorStyle;
//   Function onTap;
//   BuildListField(this.icon, this.text, this.colorStyle, this.onTap);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Padding(
//           padding: EdgeInsets.all(15.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Row(
//                 children: <Widget>[
//                   OrderColor(icon, colorStyle, () => {}),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text(
//                       text,
//                       style: GoogleFonts.kanit(
//                           fontSize: 18.0,
//                           fontWeight: FontWeight.w400,
//                           textStyle: TextStyle(color: Colors.black)),
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 padding: const EdgeInsets.all(15.0),
//                 child: InkWell(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Icon(
//                         Icons.arrow_right,
//                         color: Colors.black,
//                       ),
//                     ],
//                   ),
//                   onTap: onTap,
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
// }

// // ignore: must_be_immutable
// class OrderColor extends StatelessWidget {
//   IconData icon;
//   String colorStyle;
//   Function onTap;

//   OrderColor(this.icon, this.colorStyle, this.onTap);

//   @override
//   Widget build(BuildContext context) {
//     Color getColor() {
//       if (colorStyle == 'purple') {
//         return Color.fromRGBO(32, 51, 68, 1.0).withOpacity(0.85);
//       } else if (colorStyle == 'red') {
//         return Colors.red;
//       } else if (colorStyle == 'green') {
//         return Colors.green;
//       }
//       return Colors.green;
//     }

//     return Row(
//       children: <Widget>[
//         Container(
//           padding: const EdgeInsets.all(15.0),
//           decoration: BoxDecoration(color: getColor(), shape: BoxShape.circle),
//           child: Row(
//             children: [
//               InkWell(
//                 child: Row(
//                   children: <Widget>[
//                     Icon(
//                       icon,
//                       color: Colors.white,
//                       size: 18.0,
//                     ),
//                   ],
//                 ),
//                 onTap: onTap,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class MyProfileClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(size.width, 0);
//     path.lineTo(size.width, size.height);
//     path.lineTo(-850, 0);
//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }
