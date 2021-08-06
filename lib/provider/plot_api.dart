import 'dart:convert';

import 'package:ai_flutter/provider/api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class PlotAPI extends ApiProvider {
  PlotAPI();

  plots(int year) async {
    String _url = '$endPointFormTrr/plots';
    var body = json.encode({"FacID": "1", "QuotaNO": "74", "Year": year});
    print(_url);
    return http.post(Uri.parse(_url), headers: headers, body: body);
  }

  plotUser(int year) async {
    String _url = '$endPointFormTrr/plot_user';
    var body = json.encode({"FacID": "1", "QuotaNO": "74", "Year": year});
    print(_url);
    return http.post(Uri.parse(_url), headers: headers, body: body);
  }

  getGroupYear() async {
    String _url = '$endPointFormTrr/group_years';
    var body = json.encode({"FacID": "1", "QuotaID": "19"});
    return http.post(Uri.parse(_url), headers: headers, body: body);
  }
}
