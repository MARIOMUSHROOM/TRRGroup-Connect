import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CompanyInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('กลุ่มบริษัทน้ำตาลไทยรุ่งเรือง'),
        ),
        body: WebView(
          initialUrl: "https://www.trrgroup.com/trr-group/",
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}
