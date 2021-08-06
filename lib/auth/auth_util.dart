import 'package:flutter/material.dart';
import '../global_const.dart' as cons;
import '../global_utils.dart' as util;
import './auth_const.dart' as authCons;
// import 'package:google_fonts/google_fonts.dart';

// TextStyle ggKanit(TextStyle aTextStyle) {
//   return GoogleFonts.kanit(textStyle: aTextStyle);
// }

// void showNotValidateUserDialog({BuildContext referContext, double deviceHeight, double deviceWidth}) async {
//   await showDialog(
//     context: referContext,
//     builder: (BuildContext ctx) {
//       return util.verticalAnimation(
//         Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Container(
//             height: deviceHeight * 0.40,
//             width: deviceWidth * 0.85,
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Image(image: AssetImage('assets/images/auth/invalid_user.png'), fit: BoxFit.cover, width: 100),
//                   Expanded(
//                     child: Align(
//                       child: Text(
//                         'คุณไม่มีบัญชีในระบบ\nกรุณาติดต่อเจ้าหน้าที่\n02-345-6789',
//                         style: TextStyle(fontSize: 32),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(referContext).pop();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       elevation: 2,
//                       primary: authCons.kBlueColor,
//                       padding: EdgeInsets.symmetric(horizontal: 60, vertical: 6),
//                     ),
//                     child: Text('ตกลง', style: TextStyle(fontSize: 28)),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
