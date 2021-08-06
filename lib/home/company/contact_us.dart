import 'package:ai_flutter/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CompanyContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ติดต่อเรา',
            style: GoogleFonts.kanit(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                textStyle: TextStyle(color: Colors.white)),
          ),
          backgroundColor: kPrimaryColor,
        ),
        body: WebView(
          initialUrl: "https://www.trrgroup.com/contact-us/",
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}
