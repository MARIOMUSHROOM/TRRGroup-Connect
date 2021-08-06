import 'dart:convert';

import 'package:ai_flutter/provider/api_provider.dart';
import 'package:http/http.dart' as http;

class ExpenseAPI extends ApiProvider {
  ExpenseAPI();

  getExpenseData(String yearSelected) async {
    String _url = '$endPoint/get_expense_data/$yearSelected/1';
    print(_url);
    return http.get(Uri.parse(_url), headers: headers);
  }

  // getYearSuccessData(String yearSelected) async {
  //   String _url = '$endPoint/get_year_success_data/1';
  //   print(_url);
  //   return http.get(Uri.parse(_url), headers: headers);
  // }

  Future<http.Response> getReceiptCaneData(var date, int plot) async {
    String _url = '$endPointFormTrr/receipt_cane';
    var body = json
        .encode({"FacID": "1", "QuotaID": "74", "Ddate": date, "PlotID": plot});
    print(_url);
    return http.post(Uri.parse(_url), headers: headers, body: body);
  }
}
