import 'package:ai_flutter/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../global_const.dart' as cons;

class CompanyInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('กลุ่มบริษัทน้ำตาลไทยรุ่งเรือง',
                style: TextStyle(fontSize: 26)),
            backgroundColor: cons.kSolidBlueColor),
        body: WebView(
          initialUrl: "https://www.trrgroup.com/trr-group/",
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}
