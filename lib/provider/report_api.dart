import 'package:ai_flutter/provider/api_provider.dart';
import 'package:http/http.dart' as http;

class ReportAPI extends ApiProvider {
  ReportAPI();

  getReportList(String startYear, String endYear) async {
    String _url = '$endPoint/get_report_list/$startYear/$endYear/1';
    print(_url);
    return http.get(Uri.parse(_url), headers: headers);
  }

  getReportData(var idSuccess, int offsetStart, int offsetEnd) async {
    String _url =
        '$endPoint/get_report_data/$idSuccess/$offsetStart/$offsetEnd';
    // String _url = "http://127.0.0.1:8000/api/get_report_data/2/0/15";
    print(_url);
    return http.get(Uri.parse(_url), headers: headers);
  }
}
