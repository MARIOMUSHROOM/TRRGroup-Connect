import 'package:ai_flutter/data/news.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

List<NewsData> paseNewsData(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  List<NewsData> news = list.map((model) => NewsData.fromJson(model)).toList();
  return news;
}

bool loading = true;
final String url = 'https://www.christian-dogma.com/android-index.php';
var client = http.Client();
// List<NewsData> users = List<NewsData>();

Future<List<NewsData>> fetchNewsData() async {
  final response =
      await http.get(Uri.https('jsonplaceholder.typicode.com', '/photos'));
  if (response.statusCode == 200) {
    return compute(paseNewsData, response.body);
  } else {
    throw Exception('Request API Error');
  }
}

// await Future.delayed(Duration(seconds: 3));
// var newFetchItems = List<String>.generate(10, (index) => 'title: $index');
// paseNewsData.addAll(newFetchItems);