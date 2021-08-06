import 'dart:convert';

import 'package:ai_flutter/provider/api_provider.dart';
import 'package:http/http.dart' as http;

class JournalAPI extends ApiProvider {
  JournalAPI();

  getJournalList(var startOffset, var lastOffset) async {
    String _url = '$endPoint/get_journal_list/$startOffset/$lastOffset';
    return http.get(Uri.parse(_url), headers: headers);
  }
}
