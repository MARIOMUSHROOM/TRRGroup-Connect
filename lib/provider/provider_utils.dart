import 'package:http/http.dart' as http;
import 'dart:convert';

Future<dynamic> getDataFromAPI(String aURL, Map<String, String> aHeaders) async {
  return await http.get(Uri.parse(aURL), headers: aHeaders);
}

Future<dynamic> postDataToAPI(String aURL, Map<String, String> aHeaders, Map<String, dynamic> aBody) async {
  return await http.post(Uri.parse(aURL), headers: aHeaders, body: json.encode(aBody));
}
