import 'package:flutter/material.dart';
import '../../global_const.dart' as cons;
import 'package:google_fonts/google_fonts.dart';

final queueBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10),
  // border: Border.all(color: Colors.brown[200], width: 0.5),
  boxShadow: [BoxShadow(offset: Offset(2, 2), color: Colors.blueGrey[100], blurRadius: 0.5)],
);

TextStyle ggKanit(TextStyle aTextStyle) {
  return GoogleFonts.kanit(textStyle: aTextStyle);
}
