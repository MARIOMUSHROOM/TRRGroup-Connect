import 'dart:convert';

import 'package:ai_flutter/provider/api_provider.dart';
import 'package:http/http.dart' as http;

class LoanAPI extends ApiProvider {
  LoanAPI();

  getLoan() async {
    String _url = '$endPointFormTrr/loansnow';
    var body = json.encode({"FacID": "1", "QuotaID": "74"});
    print(_url);
    return http.post(Uri.parse(_url), headers: headers, body: body);
  }
}
