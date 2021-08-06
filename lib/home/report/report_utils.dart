import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './models/report_activity_model.dart';

typedef NotifyOnReportPlotItemTapCallBack = void Function(ReportPlotItem aReportPlotItem);

TextStyle ggKanit(TextStyle aTextStyle) {
  return GoogleFonts.kanit(textStyle: aTextStyle);
}
